module MagicSquareLib.MainMenu;

import MagicSquareLib.MagicButton;

import godot;
import godot.node.all;

import std.stdio;
import std.random;
import std.algorithm : canFind;
import core.thread;

class MainMenu : GodotScript!Control {
        alias owner this;
        
        int[][] targetNum = [ ///
        [2, 4], /// 1
                [1, 3, 5], /// 2
                [2, 6], /// 3
                [1, 5, 7], /// 4
                [2, 4, 6, 8], /// 5
                [3, 5, 9], /// 6
                [4, 8], /// 7
                [5, 7, 9], /// 8
                [6, 8] /// 9
                ];
        static foreach (i; 1 .. 10) {
                import std.conv : text;

                mixin("@Property NodePath buttonPath" ~ i.text ~ ";");
                mixin("@OnReady!buttonPath" ~ i.text ~ " MagicButton button" ~ i.text ~ ";");
                mixin("@Method void on_button" ~ i.text ~ "_pressed() {
                        switchButtonColor(" ~ i.text ~ ");
                        int[] targets = targetNum[" ~ i
                                .text ~ "-1][];
                        foreach (target; targets) {
                                switchButtonColor(target);
                        }
                }");
        }

        private void switchButtonColor(int target) {
                static foreach (i; 1 .. 10) {
                        import std.conv : text;

                        mixin("if(target == " ~ i.text ~ ") {
                                        debug print(target);
                                        button" ~ i.text ~ ".call(\"button_toggled\");
                                }");
                }
        }

        @Method void _ready() {
                static foreach (i; 1 .. 10) {
                        import std.conv : text;

                        mixin("debug assert(button" ~ i.text ~ ", \"Please Connect button" ~ i.text ~ "\");");
                        mixin("button" ~ i.text ~ ".connect(\"pressed\", this, \"on_button" ~ i.text ~ "_pressed\");");
                }
                randomizeButton();
        }

        @Method void _process(float delta) {
                if (button1.cond && button2.cond && button3.cond && button4.cond && button6.cond && button7.cond && button8
                                .cond && button8.cond && button8.cond && !button5.cond) {
                        print("You win");
                        // getTree().paused = true;
                        // Thread.sleep(dur!("seconds")(2));
                        randomizeButton();
                }
        }

        private void randomizeButton() {
                int[] selected = [0, 0, 0, 0];
                foreach (i; 0 .. 4) {
                        int trgt;
                        do {
                                trgt = [1, 2, 3, 4, 5, 6, 7, 8, 9].choice(rndGen);

                        }
                        while (selected.canFind(trgt));
                        selected[i] = trgt;
                }
                foreach (i; selected) {
                        switchButtonColor(i);
                }
        }
}
