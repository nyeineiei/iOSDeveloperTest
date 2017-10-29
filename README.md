# iOSDeveloperTest
Implemented using swift 3
Change the value in for loop from setupData() function.

func setupData() {
    //16 cells
    for _ in 0 ... 15 {
        let myDict:NSDictionary = ["Color" : self.getRandomColor(),"String" : self.randomizeAvailableLetters()]
        datasources.add(myDict)
    }
}


