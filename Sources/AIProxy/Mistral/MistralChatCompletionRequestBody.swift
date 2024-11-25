//
//  MistralChatCompletionRequestBody.swift
//
//
//  Created by Lou Zell on 11/24/24.
//

import Foundation

/// Docstrings from: https://docs.mistral.ai/api/#tag/chat
public struct MistralChatCompletionRequestBody: Encodable {

    // Required

    /// The prompt(s) to generate completions for
    public let messages: [Message]

    /// ID of the model to use. You can use the List Available Models API to see all of your
    /// available models, or see our Model overview for model descriptions.  Temperature (number)
    /// or Temperature (null) (Temperature)
    ///
    /// List Available Models API: https://docs.mistral.ai/api/#tag/models/operation/list_models_v1_models_get
    /// Model overview: https://docs.mistral.ai/models
    public let model: String

    // Optional

    /// frequency_penalty penalizes the repetition of words based on their frequency in the
    /// generated text. A higher frequency penalty discourages the model from repeating words that
    /// have already appeared frequently in the output, promoting diversity and reducing
    /// repetition.
    ///
    /// Acceptable range: [-2..2]
    /// Default: 0
    public let frequencyPenalty: Double?

    /// The maximum number of tokens to generate in the completion. The token count of your prompt
    /// plus max_tokens cannot exceed the model's context length.
    public let maxTokens: Int?

    /// Number of completions to return for each request, input tokens are only billed once.
    public let n: Int?

    /// presence_penalty determines how much the model penalizes the repetition of words or
    /// phrases. A higher presence penalty encourages the model to use a wider variety of words and
    /// phrases, making the output more diverse and creative.
    ///
    /// Acceptable range: [-2..2]
    /// Default: 0
    public let presencePenalty: Double?

    /// An object specifying the format that the model must output. Setting to `.jsonObject` enables
    /// JSON mode, which guarantees the message the model generates is in JSON. When using JSON
    /// mode you MUST also instruct the model to produce JSON yourself with a system or a user
    /// message.
    public let responseFormat: ResponseFormat?

    /// Whether to inject a safety prompt before all conversations.
    /// Default: false
    public let safePrompt: Bool?

    /// The seed to use for random sampling. If set, different calls will generate deterministic results.
    public let seed: Int?

    /// Stop generation if one of these tokens is detected
    public let stop: [String]?

    /// Whether to stream back partial progress.
    /// Default: false
    public var stream: Bool?

    /// What sampling temperature to use, we recommend between 0.0 and 0.7. Higher values like 0.7
    /// will make the output more random, while lower values like 0.2 will make it more focused and
    /// deterministic. We generally recommend altering this or `topP` but not both. The default
    /// value varies depending on the model you are targeting. Call the /models endpoint to
    /// retrieve the appropriate value.
    ///
    /// Acceptable range: [0..1]
    /// Default: 1
    public let temperature: Double?

    /// Tool calls are not implemented
    /// public let tools: [Tool]?

    /// Tool calls are not implemented
    /// public let toolChoice: ToolChoice?

    /// Nucleus sampling, where the model considers the results of the tokens with `topP`
    /// probability mass. So 0.1 means only the tokens comprising the top 10% probability mass are
    /// considered. We generally recommend altering this or `temperature` but not both.
    ///
    /// Acceptable range: [0..1]
    /// Default: 1
    public let topP: Double?

    private enum CodingKeys: String, CodingKey {
        case messages
        case model

        case frequencyPenalty = "frequency_penalty"
        case maxTokens = "max_tokens"
        case n
        case presencePenalty = "presence_penalty"
        case responseFormat = "response_format"
        case safePrompt = "safe_prompt"
        case seed
        case stop
        case stream
        case temperature
        // case tools
        // case toolChoice = "tool_choice"
        case topP = "top_p"
    }

    // This memberwise initializer is autogenerated.
    // To regenerate, use `cmd-shift-a` > Generate Memberwise Initializer
    // To format, place the cursor in the initializer's parameter list and use `ctrl-m`
    public init(
        messages: [MistralChatCompletionRequestBody.Message],
        model: String,
        frequencyPenalty: Double? = nil,
        maxTokens: Int? = nil,
        n: Int? = nil,
        presencePenalty: Double? = nil,
        responseFormat: MistralChatCompletionRequestBody.ResponseFormat? = nil,
        safePrompt: Bool? = nil,
        seed: Int? = nil,
        stop: [String]? = nil,
        stream: Bool? = nil,
        temperature: Double? = nil,
        topP: Double? = nil
    ) {
        self.messages = messages
        self.model = model
        self.frequencyPenalty = frequencyPenalty
        self.maxTokens = maxTokens
        self.n = n
        self.presencePenalty = presencePenalty
        self.responseFormat = responseFormat
        self.safePrompt = safePrompt
        self.seed = seed
        self.stop = stop
        self.stream = stream
        self.temperature = temperature
        self.topP = topP
    }
}


// MARK: - RequestBody.Message
extension MistralChatCompletionRequestBody {
    public enum Message: Encodable {
        case assistant(content: String)
        case system(content: String)
        case user(content: String)

        private enum RootKey: String, CodingKey {
            case content
            case role
        }

        public func encode(to encoder: any Encoder) throws {
            var container = encoder.container(keyedBy: RootKey.self)
            switch self {
            case .assistant(let content):
                try container.encode(content, forKey: .content)
                try container.encode("assistant", forKey: .role)
            case .system(let content):
                try container.encode(content, forKey: .content)
                try container.encode("system", forKey: .role)
            case .user(let content):
                try container.encode(content, forKey: .content)
                try container.encode("user", forKey: .role)
            }
        }
    }
}

extension MistralChatCompletionRequestBody {
    /// An object specifying the format that the model must output.
    /// Setting to `{ "type": "json_object" }` enables JSON mode, which guarantees the message the model generates is valid JSON.
    /// Important: when using JSON mode, you must also instruct the model to produce JSON yourself via a system or user message.
    public enum ResponseFormat: Encodable {

        /// Enables JSON mode, which ensures the message the model generates is valid JSON.
        /// Important: when using JSON mode, you must also instruct the model to produce JSON yourself via a
        /// system or user message.
        case jsonObject

        /// Instructs the model to produce text only.
        case text

        private enum RootKey: String, CodingKey {
            case type
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: RootKey.self)
            switch self {
            case .jsonObject:
                try container.encode("json_object", forKey: .type)
            case .text:
                try container.encode("text", forKey: .type)
            }
        }
    }
}