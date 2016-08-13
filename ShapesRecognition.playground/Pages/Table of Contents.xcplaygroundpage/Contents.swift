/*:
 In this playground I will share my experience that I got few years ago building an iPad app for creating diagrams of different kind. One of its key features was freehand drawn shapes recognition.
 
 Comparing with general objects recognition task shapes recognition can be not that complex, though there are a lot of math and pretty complex algorithms involved. And non of the technique consists of a single algorithm. Each of them requires several computation steps. Here I will describe the technique I used which is based on the extraction of shape's features. It was very well described by __Lauri Vanhatalo__ in his diploma paper ["Online Sketch Recognition: Geometric Shapes"](http://lib.tkk.fi/Dipl/2011/urn100500.pdf). In conclusion he claims that this method has an overal recognition rate of _78%_ what is not that much but looks like suitable for the domain. Comparing with other methods that often require machine learning and neural networks this one looks like the easiest to implement. 
 
 ### Table of Contents
 
 * [Smooth drawing](Smooth%20drawing)
 * [Curve preprocessing](Curve%20preprocessing)
    * [Douglas-Peucker algorithm](Douglas-Peucker%20algorithm)
 * Feature extraction
 * Shape decision
 
 [Next: Smooth drawing](@next)
 */
