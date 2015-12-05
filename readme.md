Media playback controller for iOS AVPlayer with color-coded time spans drawn to seek bar background.

"InformativeSeekbar" is a custom UIControl for iOS for controlling an AVPlayer. It contains an array of "TimespanSeries" objects, each composed of a color and an array of "Timespan" objects (start/end times). The Timespans are drawn as a solid color to the background of the playback controller's seek bar.

This control was developed as part of an ergonomic analysis application for indicating time frames within a video where the recorded subject assumed certain postures or experienced certain levels of physical strain. However, the code here is generalized and suitable for many uses. TimespanSeries is intended to be extended (or subclassed) to attach meaningful data to each set of Timespans.

An included example shows how the control is used and its visual appearance customized.
