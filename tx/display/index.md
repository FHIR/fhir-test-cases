These tests exist to test out the various possibilities for validating display names depending on the specified language.


| Test Case | Display Valid?  | Request Language | CodeSystem language | Comments  |
| ----------- | ----------- |----------- |----------- |----------- |
| validation-right-none-none   | Yes | -- | --    | |
| validation-right-none-en     | Yes | -- | en    | |
| validation-right-none-ende   | Yes | -- | en+de | |
| validation-right-none-ende-N | Yes | -- | en+de (missing) | |
| validation-wrong-none-none   | No  | -- | -- | |
| validation-wrong-none-en     | No  | -- | en | |
| validation-wrong-none-ende   | No  | -- | en+de | |
| validation-wrong-none-ende-N | No  | -- | en+de (missing) | |
| validation-right-en-none     | Yes | en | -- | |
| validation-right-en-en       | Yes | en | en | |
| validation-right-en-ende     | Yes | en | en+de | |
| validation-right-en-ende-N   | Yes | en | en+de (missing) | |
| validation-wrong-en-none     | No  | en | -- | |
| validation-wrong-en-en       | No  | en | en | |
| validation-wrong-en-ende     | No  | en | en+de | |
| validation-wrong-en-ende-N   | No  | en | en+de (missing)| |
| validation-right-de-none     | Yes | de | -- | |
| validation-right-de-en       | Yes | de | en | |
| validation-right-de-ende     | Yes | de | en+de | |
| validation-right-de-ende-N   | Yes | de | en+de (missing) | |
| validation-wrong-de-none     | No  | de | -- | |
| validation-wrong-de-en       | No  | de | en | |
| validation-wrong-de-ende     | No  | de | en+de | |
| validation-wrong-de-ende-N   | No  | de | en+de (missing) | |
