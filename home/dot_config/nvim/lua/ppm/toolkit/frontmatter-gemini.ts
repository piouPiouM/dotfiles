import * as O from 'fp-ts/Option';
import * as A from 'fp-ts/Array';
import * as E from 'fp-ts/Either';
import { pipe } from 'fp-ts/function';

type FrontmatterData = Record<string, string | number | boolean | {} | string[]>;

const trim = (str: string): string => str.trim();

const parse_value = (valueString: string): string | number | boolean | {} | string[] => {
  const value = trim(valueString);
  if (value === "[]") return [];
  if (value === "{}") return {};
  const num = Number(value);
  if (!isNaN(num)) return num;
  if (value === "true") return true;
  if (value === "false") return false;
  return value;
};

const parse_line = (line: string): O.Option<[string, string]> => {
  const match = line.match(/^([^:]+):\s*(.+)$/);
  return match ? O.some([trim(match[1]), match[2]]) : O.none;
};

const parse_list_item = (line: string): O.Option<string> => {
  const match = line.match(/^\s*-\s*(.+)$/);
  return match ? O.some(match[1]) : O.none;
};

const handle_line_with_value = (data: FrontmatterData, key: string, valueString: string): E.Either<string, FrontmatterData> => {
  const parsedValue = parse_value(valueString)
  return E.right({ ...data, [key]: parsedValue })
}

const handle_list_item = (data: FrontmatterData, key: string, item: string): E.Either<string, FrontmatterData> => {
  const parsedItem = parse_value(item)
  const existingValue = data[key]
  if (Array.isArray(existingValue)) {
    return E.right({ ...data, [key]: [...existingValue, parsedItem] })
  } else if (existingValue === undefined) {
    return E.right({ ...data, [key]: [parsedItem] })
  } else {
    return E.left("Invalid list syntax")
  }
}

const process_line = (
  data: FrontmatterData,
  currentKey: O.Option<string>,
  line: string
): E.Either<string, FrontmatterData> => {

  const parsedLine = parse_line(line)
  if (O.isSome(parsedLine)) {
    const [key, valueString] = parsedLine.value
    return handle_line_with_value(data, key, valueString)
  }

  const parsedListItem = parse_list_item(line)
  if (O.isSome(parsedListItem)) {
    const item = parsedListItem.value
    return pipe(
      currentKey,
      O.fold(
        () => E.left("List item without a key"),
        (key) => handle_list_item(data, key, item)
      )
    )
  }

  return E.right(data);
};

export const parseFrontmatter = (frontmatterString: string): E.Either<string, FrontmatterData> => {
  const lines = frontmatterString.split('\n').map(trim);

  const initialData: FrontmatterData = {};

  let inFrontmatter = false;
  let currentKey: O.Option<string> = O.none;

  for (const line of lines) {
    if (line === "---") {
      inFrontmatter = !inFrontmatter;
      if (!inFrontmatter) break; // Exit after closing "---"
      continue; // Skip the "---" line itself
    }

    if (inFrontmatter) {
      const result = process_line(initialData, currentKey, line)
      if (E.isLeft(result)) {
        return result
      } else {
          initialData = result.right
          currentKey = parse_line(line).map(([k, _]) => k)
      }
    }
  }

  return inFrontmatter ? E.left("Frontmatter not closed") : E.right(initialData);
};