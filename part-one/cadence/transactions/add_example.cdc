import One from "../contracts/One.cdc"

transaction(field: String) {
    execute {
        One.addExample(field)
    }
}