pub contract One {

    pub struct Example {
        pub let field: String
        init (field: String) {
            self.field = field
        }
    }

    access(contract) let examples: [Example]

    pub fun addExample(_ field: String) {
        self.examples.append(Example(field: field))
    }

    pub fun getExamples(): [Example] {
        return self.examples
    }

    init() {
        self.examples = []
    }
}
 