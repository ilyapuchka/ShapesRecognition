/*: 
 [Previous: Smooth drawing](@previous) | [Table of Contents](Table%20of%20Contents)
 ## Curve preprocessing.
 
 When drawing by hand, especially in a slow manner, we will get a lot of touch points and the resulting curve will contain lots of close points. Also we can not draw ideally, so resulting curve can contain artifacts like hooklet at the end of the curve, closed shapes can not be ideally closed. These artifacts are insignificant for recognizing a shape and only complicate calculations. To eliminate deviation from "ideal" curve there are different preprocessing algorithms that we can apply before proceeding to the next steps of shape recognition.

 [Next: Douglas-Peucker algorithm](@next) | [Table of Contents](Table%20of%20Contents)
 */
