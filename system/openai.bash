#!/usr/bin/bash

hey_gpt() {
    DATA='{ "model": "gpt-3.5-turbo", "messages": [{"role": "user", "content": "'$1'"}], "temperature": 0.7 }'
    curl https://api.openai.com/v1/chat/completions -s \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer $OPENAI_API_KEY" \
        -d "$DATA" | jq -r '.choices[0].message.content'
}

hey_gpt "$1"
