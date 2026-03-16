local model = {
  {
    billing = {
      isPremium = false,
      multiplier = 0,
    },
    capabilities = {
      supports = {
        vision = true,
      },
    },
    id = "gpt-4.1",
    isChatDefault = true,
    isChatFallback = true,
    modelFamily = "gpt-4.1",
    modelName = "GPT-4.1",
    modelPolicy = {
      state = "enabled",
      terms =
      "Enable access to the latest GPT-4.1 model from OpenAI. [Learn more about how GitHub Copilot serves GPT-4.1](https://docs.github.com/en/copilot/using-github-copilot/ai-models/choosing-the-right-ai-model-for-your-task#gpt-41).",
    },
    preview = false,
    scopes = { "chat-panel", "edit-panel", "inline", "agent-panel" },
  },
  {
    billing = {
      isPremium = false,
      multiplier = 0,
    },
    capabilities = {
      supports = {
        vision = true,
      },
    },
    id = "gpt-5-mini",
    isChatDefault = false,
    isChatFallback = false,
    modelFamily = "gpt-5-mini",
    modelName = "GPT-5 mini",
    modelPolicy = {
      state = "enabled",
      terms =
      "Enable access to the latest GPT-5 mini model from OpenAI. [Learn more about how GitHub Copilot serves GPT-5 mini](https://gh.io/copilot-openai).",
    },
    preview = false,
    scopes = { "chat-panel", "edit-panel", "inline", "agent-panel" },
  },
  {
    billing = {
      isPremium = true,
      multiplier = 1,
    },
    capabilities = {
      supports = {
        vision = true,
      },
    },
    id = "gpt-5",
    isChatDefault = false,
    isChatFallback = false,
    modelFamily = "gpt-5",
    modelName = "GPT-5",
    modelPolicy = {
      state = "enabled",
      terms =
      "Enable access to the latest GPT-5 model from OpenAI. [Learn more about how GitHub Copilot serves GPT-5](https://gh.io/copilot-openai).",
    },
    preview = false,
    scopes = { "chat-panel", "edit-panel", "inline", "agent-panel" },
  },
  {
    billing = {
      isPremium = false,
      multiplier = 0,
    },
    capabilities = {
      supports = {
        vision = true,
      },
    },
    id = "gpt-4o",
    isChatDefault = false,
    isChatFallback = false,
    modelFamily = "gpt-4o",
    modelName = "GPT-4o",
    preview = false,
    scopes = { "chat-panel", "edit-panel", "inline", "agent-panel" },
  },
  {
    billing = {
      isPremium = false,
      multiplier = 0,
    },
    capabilities = {
      supports = {
        vision = false,
      },
    },
    id = "gpt-41-copilot",
    isChatDefault = false,
    isChatFallback = false,
    modelFamily = "gpt-4.1",
    modelName = "GPT-4.1 Copilot",
    preview = false,
    scopes = { "completion" },
  },
  {
    billing = {
      isPremium = false,
      multiplier = 0,
    },
    capabilities = {
      supports = {
        vision = false,
      },
    },
    id = "grok-code-fast-1",
    isChatDefault = false,
    isChatFallback = false,
    modelFamily = "grok-code",
    modelName = "Grok Code Fast 1",
    modelPolicy = {
      state = "enabled",
      terms =
      "Enable access to the latest Grok Code Fast 1 model from xAI. If enabled, you instruct GitHub Copilot to send data to xAI Grok Code Fast 1. [Learn more about how GitHub Copilot serves Grok Code Fast 1](https://docs.github.com/en/copilot/reference/ai-models/model-hosting#xai-models). During launch week, [promotional pricing is 0x](https://gh.io/copilot-grok-code-promo).",
    },
    preview = false,
    scopes = { "chat-panel", "edit-panel", "inline", "agent-panel" },
  },
  {
    billing = {
      isPremium = true,
      multiplier = 1,
    },
    capabilities = {
      supports = {
        vision = true,
      },
    },
    id = "claude-sonnet-4",
    isChatDefault = false,
    isChatFallback = false,
    modelFamily = "claude-sonnet-4",
    modelName = "Claude Sonnet 4",
    modelPolicy = {
      state = "enabled",
      terms =
      "Enable access to the latest Claude Sonnet 4 model from Anthropic. [Learn more about how GitHub Copilot serves Claude Sonnet 4](https://docs.github.com/en/copilot/using-github-copilot/ai-models/using-claude-sonnet-in-github-copilot).",
    },
    preview = false,
    scopes = { "chat-panel", "edit-panel", "inline", "agent-panel" },
  },
  {
    billing = {
      isPremium = true,
      multiplier = 1,
    },
    capabilities = {
      supports = {
        vision = true,
      },
    },
    id = "claude-sonnet-4.5",
    isChatDefault = false,
    isChatFallback = false,
    modelFamily = "claude-sonnet-4.5",
    modelName = "Claude Sonnet 4.5",
    modelPolicy = {
      state = "enabled",
      terms =
      "Enable access to the latest Claude Sonnet 4.5 model from Anthropic. [Learn more about how GitHub Copilot serves Claude Sonnet 4.5](https://docs.github.com/en/copilot/using-github-copilot/ai-models/using-claude-sonnet-in-github-copilot).",
    },
    preview = false,
    scopes = { "chat-panel", "edit-panel", "inline", "agent-panel" },
  },
  {
    billing = {
      isPremium = true,
      multiplier = 1,
    },
    capabilities = {
      supports = {
        vision = true,
      },
    },
    id = "gemini-2.5-pro",
    isChatDefault = false,
    isChatFallback = false,
    modelFamily = "gemini-2.5-pro",
    modelName = "Gemini 2.5 Pro",
    modelPolicy = {
      state = "enabled",
      terms =
      "Enable access to the latest Gemini 2.5 Pro model from Google. [Learn more about how GitHub Copilot serves Gemini 2.5 Pro](https://docs.github.com/en/copilot/using-github-copilot/ai-models/choosing-the-right-ai-model-for-your-task#gemini-25-pro).",
    },
    preview = false,
    scopes = { "chat-panel", "edit-panel", "inline", "agent-panel" },
  },
  {
    capabilities = {
      supports = {
        vision = true,
      },
    },
    id = "auto",
    isChatDefault = false,
    isChatFallback = false,
    modelFamily = "auto",
    modelName = "Auto",
    preview = false,
    scopes = { "inline", "chat-panel", "edit-panel", "agent-panel" },
  },
}