class GeminiChatService
  include HTTParty
  base_uri "https://generativelanguage.googleapis.com/v1beta"

  def initialize
    @api_key = Rails.application.credentials.dig(:gemini, :api_key)
  end

  def chat(prompt)
    body = {
      contents: [{ parts: [{ text: prompt }] }]
    }

    Rails.logger.debug "Sending request to Gemini API with body: #{body.to_json}"

    # 使用するモデル名を「gemini-2.0-flash-lite-001」に変更
    response = self.class.post(
      "/models/gemini-2.0-flash-lite-001:generateContent?key=#{@api_key}",
      headers: { "Content-Type" => "application/json" },
      body: body.to_json
    )

    Rails.logger.debug "Received response: #{response.body}"

    if response.success?
      parsed = JSON.parse(response.body)
      parsed.dig("candidates", 0, "content", "parts", 0, "text") || "No response"
    else
      "Error: Could not get a response from the API. Status: #{response.code}, Body: #{response.body}"
    end
  end
end
