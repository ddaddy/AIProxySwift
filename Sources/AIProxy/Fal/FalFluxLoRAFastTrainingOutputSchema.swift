//
//  FalFluxLoRAFastTrainingOutputSchema.swift
//
//
//  Created by Lou Zell on 10/3/24.
//

import Foundation

/// Docstrings from https://fal.ai/models/fal-ai/flux-lora-fast-training/api#schema-output
public struct FalFluxLoRAFastTrainingOutputSchema: Decodable {

    /// Remote training configuration file.
    public let configFile: File?

    /// Remote file holding the trained diffusers lora weights.
    public let diffusersLoraFile: File?

    private enum CodingKeys: String, CodingKey {
        case configFile = "config_file"
        case diffusersLoraFile = "diffusers_lora_file"
    }
}

// MARK: - OutputSchema.File
public extension FalFluxLoRAFastTrainingOutputSchema {
    struct File: Decodable {
        /// The mime type of the file.
        public let contentType: String?

        /// The name of the file. It will be auto-generated if not provided.
        public let fileName: String?

        /// The size of the file in bytes.
        public let fileSize: Int?

        /// The URL where the file can be downloaded from.
        public let url: URL?

        private enum CodingKeys: String, CodingKey {
            case contentType = "content_type"
            case fileName = "file_name"
            case fileSize = "file_size"
            case url
        }
    }
}