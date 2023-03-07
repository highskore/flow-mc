access(all) contract SomeContract {

    pub var testStruct: SomeStruct

    pub struct SomeStruct {

        //
        // 4 Variables
        //

        pub(set) var a: String
        pub var b: String
        access(contract) var c: String
        access(self) var d: String

        //
        // 3 Functions
        //

        pub fun publicFunc() {}
        access(contract) fun contractFunc() {}
        access(self) fun privateFunc() {}

        pub fun structFunc() {

            /**************/
            /*** AREA 1 ***/
            /**************/
            
            // a = read, write
            // b = read, write
            // c = read, write
            // d = read, write

            // publicFunc = callable
            // contractFunc = callable
            // privateFunc = callable
        }

        init() {
            self.a = "a"
            self.b = "b"
            self.c = "c"
            self.d = "d"
        }
    }

    pub resource SomeResource {

        pub var e: Int

        pub fun resourceFunc() {

            /**************/
            /*** AREA 2 ***/
            /**************/

            // a = read, write
            // b = read
            // c = read
            // d = --

            // publicFunc = callable
            // contractFunc = callable
            // privateFunc = --
        }
        
        init() {
            self.e = 17
        }
    }
    
    pub fun createSomeResource(): @SomeResource {

        return <- create SomeResource()

    }

    pub fun questsAreFun() {
        /**************/
        /*** AREA 3 ****/
        /**************/

        // a = read, write
        // b = read
        // c = read
        // d = --

        // publicFunc = callable
        // contractFunc = callable
        // privateFunc = --
    }

    init() {
        self.testStruct = SomeStruct()
    }
}