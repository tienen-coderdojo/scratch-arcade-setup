# Scratch Arcade hardware

## Required hardware

- Raspberry Pi model 3 (B+ is recommended, it might work on 3A+ but I haven't
been able to test that yet).

For the joysticks and buttons we have found 2 alternatives.

## Option 1 : Pimoroni Picade X Hat

The easiest is the [Pimoroni Picade X Hat](https://shop.pimoroni.com/products/picade-x-hat).

The requirements are :
- the Pimoroni X Hat board (https://shop.pimoroni.com/products/picade-x-hat)
- the Picade Wiring loom (https://shop.pimoroni.com/products/picade-wiring-loom-v2)
- a joystick (https://shop.pimoroni.com/products/joystick)
- some arcade buttons (https://shop.pimoroni.com/products/colourful-arcade-buttons)

We have 7 buttons per arcade, 3 buttons per player for 2-player games or the
joystick and up to 6 buttons for single player games, and 1 reset button (to
allow players to switch between different games on the arcade).

## Option 2 : a generic USB arcade encoder

The (cheaper) alternative is a generic USB arcade encoder. You can find these
online in sets including a joystick, all required wires and arcade buttons.

e.g. https://www.amazon.de/dp/B07BN97FN8

This alternative is slightly more awkward because it requires extra software
running in the background to convert the game controller input to keyboard
events, but once setup correctly it works pretty good.

**Tip:** If you order these via Amazon make sure it's a "Fulfilled by Amazon"
partner, otherwise it could take a while for your order to arrive (as most
of the sellers are located in China).
