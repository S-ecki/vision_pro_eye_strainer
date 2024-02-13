# Vision Pro feat Moorhuhn: The eye (s)trainer 🐔

This application was developed during the first Vision Pro Hackathon in Vienna.
It's a homage to the classic point-and-click game "Moorhuhn" and was developed using Flutter targeting the Vision Pro.
The game also won me the 1st place in the hackathon, which was a nice surprise. 😎

## Goals
- Fool around with the **Vision Pro** 🥽
- Test out the capabilities and limitations using pure **Flutter** 💙
- Create something engaging 🐔
- Have fun with the other participants and eat lots of free food 🍕

### The Vision

Have an "aim trainer" like game, where you just look at targets and blink to shoot them. 
Bonus points for shooting lasers from the eyes.

### The Limitations

Eye movement events are **not** exposed through any API. \
As there are hover effects when looking at buttons etc, we hoped to receive some kind of callback (similar to `onHover`) as the eyes are basically your cursor. This was not the case, also not using native Swift code.

Also, there was no way to receive events for blinking or winking when writing this.

### The Workaround

Within VisionOS, you "click" things by pinching your fingers. Those click events are exposed, so we could use the common `onTap` event.
This was less exciting, but still an OK compromise. At least the gameplay could be explained by emojis: `👀 + 👌🏼`

### The Game

To create a more engaging experience, I decided to add assets from "Moorhuhn", some goofy sound effects, animations and a level system, where the game gets harder over time.

This ended up being enough for some giggles from testers and a good time developing it. I also created an exaggerated description for the hackathon presentations: 

> #####Vision Pro feat. Moorhuhn: the eye (s)trainer
>In a new era of virtual interactions, where everything depends on the precision of your eyesight, it is about time you invest some time to train them!
>The revolutionary ‚eye (s)trainer’ combines an old classic point-and-click with cutting-edge spatial computing and an immersive surround sound.
>Start training today and become a certified Vision Bro!

#### Setup Note

The Vision Pro **cannot** be set as a target device within VSCode at the moment of writing this. This creates the necessity of running the application in XCode (with everything tedious that comes with it).\
 At least the setup itself is quite easy, following [this article]( https://simonauer.medium.com/how-to-get-started-with-flutter-and-visionos-apple-vision-pro-4335c3243248).
For a somewhat smoother experience, I developed most of the application with MacOS and only ran it from time to time on the Vision Pro to get a feeling for the UX.

## Conclusion
- Flutter runs everywhere, where pixels are painted! 💙
- The Vision Pro is an interesting device, but not as different to other VR headsets as I expected.
- Some events that would create a more immersive experience are not exposed (yet?).
- Eyes being the cursor and pinches being clicks opens new possibilities for UX design.\
- Moorhuhn is still a fun game 🐔