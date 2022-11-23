// The Kaleidoscope core
#include "Kaleidoscope.h"

// Support for keys that move the mouse
#include "Kaleidoscope-MouseKeys.h"

// Support for controlling the keyboard's LEDs
#include "Kaleidoscope-LEDControl.h"

// Support for LED modes that set all LEDs to a single color
#include "Kaleidoscope-LEDEffect-SolidColor.h"

// Support for host power management (suspend & wakeup)
#include "Kaleidoscope-HostPowerManagement.h"

// Support for magic combos (key chords that trigger an action)
#include "Kaleidoscope-MagicCombo.h"

// Support for USB quirks, like changing the key state report protocol
#include "Kaleidoscope-USB-Quirks.h"

// Support for Space Cadet
#include "Kaleidoscope-SpaceCadet.h"

/** The Model 01 / 100 's key layouts are defined as 'keymaps'. By default, there are three
  * keymaps: The standard QWERTY keymap, the "Function layer" keymap and the "Numpad"
  * keymap.
  *
  * Each keymap is defined as a list using the 'KEYMAP_STACKED' macro, built
  * of first the left hand's layout, followed by the right hand's layout.
  *
  * Keymaps typically consist mostly of `Key_` definitions. There are many, many keys
  * defined as part of the USB HID Keyboard specification. You can find the names
  * (if not yet the explanations) for all the standard `Key_` defintions offered by
  * Kaleidoscope in these files:
  *    https://github.com/keyboardio/Kaleidoscope/blob/master/src/kaleidoscope/key_defs_keyboard.h
  *    https://github.com/keyboardio/Kaleidoscope/blob/master/src/kaleidoscope/key_defs_consumerctl.h
  *    https://github.com/keyboardio/Kaleidoscope/blob/master/src/kaleidoscope/key_defs_sysctl.h
  *    https://github.com/keyboardio/Kaleidoscope/blob/master/src/kaleidoscope/key_defs_keymaps.h
  *
  * Additional things that should be documented here include
  *   using ___ to let keypresses fall through to the previously active layer
  *   using XXX to mark a keyswitch as 'blocked' on this layer
  *   using ShiftToLayer() and LockLayer() keys to change the active keymap.
  *   keeping NUM and FN consistent and accessible on all layers
  *
  * The PROG key is special, since it is how you indicate to the board that you
  * want to flash the firmware. However, it can be remapped to a regular key.
  * When the keyboard boots, it first looks to see whether the PROG key is held
  * down; if it is, it simply awaits further flashing instructions. If it is
  * not, it continues loading the rest of the firmware and the keyboard
  * functions normally, with whatever binding you have set to PROG. More detail
  * here: https://community.keyboard.io/t/how-the-prog-key-gets-you-into-the-bootloader/506/8
  *
  * The "keymaps" data structure is a list of the keymaps compiled into the firmware.
  * The order of keymaps in the list is important, as the ShiftToLayer(#) and LockLayer(#)
  * macros switch to key layers based on this list.
  *
  *

  * A key defined as 'ShiftToLayer(FUNCTION)' will switch to FUNCTION while held.
  * Similarly, a key defined as 'LockLayer(NUMPAD)' will switch to NUMPAD when tapped.
  */

/**
  * Layers are "0-indexed" -- That is the first one is layer 0. The second one is layer 1.
  * The third one is layer 2.
  * This 'enum' lets us use names like QWERTY, FUNCTION, and NUMPAD in place of
  * the numbers 0, 1 and 2.
  *
  */
enum { PRIMARY, FUNCTION };


// *INDENT-OFF*
KEYMAPS(

  [PRIMARY] = KEYMAP_STACKED
  (Consumer_AL_Calculator, Key_1, Key_2, Key_3, Key_4, Key_5, Key_LEDEffectNext,
   Key_Backtick,           Key_Q, Key_W, Key_E, Key_R, Key_T, Key_Tab,
   Key_PageUp,             Key_A, Key_S, Key_D, Key_F, Key_G,
   Key_PageDown,           Key_Z, Key_X, Key_C, Key_V, Key_B, Key_Escape,
   Key_LeftControl, Key_LeftShift, Key_LeftGui, Key_LeftAlt,
   ShiftToLayer(FUNCTION),

   Consumer_AL_Local_MachineBrowser, Key_6, Key_7, Key_8,     Key_9,      Key_0,         XXX,
   Key_Enter,                        Key_Y, Key_U, Key_I,     Key_O,      Key_P,         Key_Equals,
                                     Key_H, Key_J, Key_K,     Key_L,      Key_Semicolon, Key_Quote,
   Key_PcApplication,                Key_N, Key_M, Key_Comma, Key_Period, Key_Slash,     Key_Minus,
   Key_RightAlt, Key_RightGui, Key_RightShift, Key_RightControl,
   ShiftToLayer(FUNCTION)),


  [FUNCTION] =  KEYMAP_STACKED
  (Key_Pause,       Key_F1,            Key_F2,           Key_F3,        Key_F4,           Key_F5,           Key_LEDEffectPrevious,
   Key_PrintScreen, Key_Insert,        Key_mouseBtnL,    Key_mouseUp,   Key_mouseBtnR,    Key_mouseWarpEnd, Key_mouseWarpNE,
   Key_Home,        Key_mouseScrollUp, Key_mouseL,       Key_mouseDn,   Key_mouseR,       Key_mouseWarpNW,
   Key_End,         Key_mouseScrollDn, Key_mouseScrollL, Key_mouseBtnM, Key_mouseScrollR, Key_mouseWarpSW,  Key_mouseWarpSE,
   ___, ___, ___, ___,
   ___,

   Consumer_ScanPreviousTrack,               Key_F6,                  Key_F7,               Key_F8,                   Key_F9,                   Key_F10,          Key_CapsLock,
   ___,                                      Consumer_ScanNextTrack,  Key_LeftCurlyBracket, Key_RightCurlyBracket,    Key_LeftBracket,          Key_RightBracket, Key_F11,
                                             Key_LeftArrow,           Key_DownArrow,        Key_UpArrow,              Key_RightArrow,           XXX,              Key_F12,
   Consumer_AL_TerminalLockSlashScreensaver, Consumer_PlaySlashPause, Consumer_Mute,        Consumer_VolumeDecrement, Consumer_VolumeIncrement, Key_Backslash,    Key_Pipe,
   ___, ___, Key_Delete, ___,
   ___)
)
// *INDENT-ON*

// These 'solid' color effect definitions define a rainbow of
// LED color modes calibrated to draw 500mA or less on the
// Keyboardio Model 01 / 100.
static kaleidoscope::plugin::LEDSolidColor solidRed(160, 0, 0);
static kaleidoscope::plugin::LEDSolidColor solidOrange(160, 40, 0);
static kaleidoscope::plugin::LEDSolidColor solidYellow(160, 123, 0);
static kaleidoscope::plugin::LEDSolidColor solidGreen(0, 160, 0);
static kaleidoscope::plugin::LEDSolidColor solidBlue(0, 0, 170);
static kaleidoscope::plugin::LEDSolidColor solidViolet(130, 0, 120);

/** toggleLedsOnSuspendResume toggles the LEDs off when the host goes to sleep,
 * and turns them back on when it wakes up.
 */
void toggleLedsOnSuspendResume(kaleidoscope::plugin::HostPowerManagement::Event event) {
  switch (event) {
  case kaleidoscope::plugin::HostPowerManagement::Suspend:
    LEDControl.disable();
    break;
  case kaleidoscope::plugin::HostPowerManagement::Resume:
    LEDControl.enable();
    break;
  case kaleidoscope::plugin::HostPowerManagement::Sleep:
    break;
  }
}

/** hostPowerManagementEventHandler dispatches power management events (suspend,
 * resume, and sleep) to other functions that perform action based on these
 * events.
 */
void hostPowerManagementEventHandler(kaleidoscope::HostPowerManagement::Event event) {
  toggleLedsOnSuspendResume(event);
}

/** This 'enum' is a list of all the magic combos used by the Model 01 / 100's
 * firmware The names aren't particularly important. What is important is that
 * each is unique.
 *
 * These are the names of your magic combos. They will be used by the
 * `USE_MAGIC_COMBOS` call below.
 */
enum {
  COMBO_TOGGLE_NKRO_MODE
};

/** Wrappers, to be used by MagicCombo. **/

/**
 * This simply toggles the keyboard protocol via USBQuirks, and wraps it within
 * a function with an unused argument, to match what MagicCombo expects.
 */
static void toggleKeyboardProtocol(uint8_t combo_index) {
  USBQuirks.toggleKeyboardProtocol();
}

/** Magic combo list, a list of key combo and action pairs the firmware should
 * recognise.
 */
USE_MAGIC_COMBOS({.action = toggleKeyboardProtocol,
                  // Left Fn + Esc + Shift
                  .keys = { R3C6, R2C6, R3C7 }
                 });

// First, tell Kaleidoscope which plugins you want to use.
// Note: The order is important, LED effects are added in the order they're listed here.
KALEIDOSCOPE_INIT_PLUGINS(
  // LEDControl provides support for other LED modes
  LEDControl,

  // We start with the LED effect that turns off all the LEDs.
  LEDOff,
  solidRed,
  solidOrange,
  solidYellow,
  solidGreen,
  solidBlue,
  solidViolet,

  // The Space Cadet plugin.
  SpaceCadet,
  
  // The MouseKeys plugin lets you add keys to your keymap which move the mouse.
  MouseKeys,

  // The HostPowerManagement plugin allows us to turn LEDs off when then host
  // goes to sleep, and resume them when it wakes up.
  HostPowerManagement,

  // The MagicCombo plugin lets you use key combinations to trigger custom
  // actions - a bit like Macros, but triggered by pressing multiple keys at the
  // same time.
  MagicCombo,

  // The USBQuirks plugin lets you do some things with USB that we aren't
  // comfortable - or able - to do automatically, but can be useful
  // nevertheless. Such as toggling the key report protocol between Boot (used
  // by BIOSes) and Report (NKRO).
  USBQuirks
);

void setup() {
  Kaleidoscope.setup();
  
  LEDOff.activate();
  
  MouseKeys.speed = 3;
  MouseKeys.setSpeedLimit(25);

  //Set the keymap with a 250ms timeout per-key
  //Setting is {KeyThatWasPressed, AlternativeKeyToSend, TimeoutInMS}
  //Note: must end with the SPACECADET_MAP_END delimiter
  static kaleidoscope::plugin::SpaceCadet::KeyBinding spacecadetmap[] = {
    {Key_LeftControl, Key_LeftBracket, 220}, 
    {Key_LeftShift, Key_Space, 220}, 
    {Key_LeftGui, Key_LeftParen, 220}, 
    {Key_LeftAlt, Key_LeftCurlyBracket, 220}, 

    {Key_RightAlt, Key_RightCurlyBracket, 220},
    {Key_RightGui, Key_RightParen, 220},
    {Key_RightShift, Key_Backspace, 220},
    {Key_RightControl, Key_RightBracket, 220},
    
    SPACECADET_MAP_END
  };
  SpaceCadet.map = spacecadetmap;
  
}

/** loop is the second of the standard Arduino sketch functions.
  * As you might expect, it runs in a loop, never exiting.
  *
  * For Kaleidoscope-based keyboard firmware, you usually just want to
  * call Kaleidoscope.loop(); and not do anything custom here.
  */
void loop() {
  Kaleidoscope.loop();
}
