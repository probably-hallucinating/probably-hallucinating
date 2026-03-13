---
name: FxEmbed/FxTwitter API
description: Free API for reading Twitter/X user and tweet data without using paid X API read endpoints
type: reference
---

The FxTwitter API provides free read access to Twitter/X data. Use this instead of paid X API read endpoints.

## User lookup
`https://api.fxtwitter.com/{username}` — returns JSON with user object including numeric `id`, display name, bio, etc.

## Tweet lookup
`https://api.fxtwitter.com/{username}/status/{tweet_id}` — returns JSON with tweet content, engagement metrics, etc.

## Usage
- Fetch via WebFetch tool
- Returns JSON that can be parsed for numeric user IDs (needed for `follow_user`), tweet content, etc.
- No authentication required
- No cost — this is a free, open-source service
