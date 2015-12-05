Media playback controller for iOS AVPlayer with color-coded time spans drawn to seek bar background.

"InformativeSeekbar" is a custom UIControl for iOS for controlling an AVPlayer. Contains an array of "TimespanSeries" objects, each composed of a color and an array of "Timespan" objects (start/end times). Each Timespan is drawn as a solid color to the background of the playback controller's seek bar using the color of the containing TimespanSeries.

This control was developed as part of an ergonomic analysis application for indicating time frames within a video during which the recorded subject assumed certain postures or experienced certain levels of physical strain. However, the code here is generalized and suitable for many uses. TimespanSeries is intended to be extended (or subclassed) to incorporate meaningful data to each set of Timespans.

An included example shows how the control is used and its visual appearance customized.
