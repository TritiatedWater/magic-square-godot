import godot;

import std.stdio;

import MagicSquareLib.MainMenu;
import MagicSquareLib.MagicButton;

mixin GodotNativeLibrary!( ///
        "MagicSquareLib", ///
        MagicButton, ///
        MainMenu,
        (GodotInitOptions o) { ///
                debug print("Initializing library"); ///
                debug print("Godot is in ", o.in_editor ? "EDITOR" : "GAME", " mode."); ///
        },     
        (GodotTerminateOptions o) {  ///
                debug print("Terminating library"); ///
        }); ///
