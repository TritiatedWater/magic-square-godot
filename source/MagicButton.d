module MagicSquareLib.MagicButton;

import godot;
import godot.node.all;

class MagicButton : GodotScript!Button {
        alias owner this;

        private AnimationPlayer anim;
        private bool _cond;
        @Property NodePath animPath;

        @property bool cond() {
                return _cond;
        }
        @property void cond(bool arg) {
                _cond = arg;
        }

        @Method void _ready() {
                anim = getNode(animPath).as!AnimationPlayer;
                debug assert(anim, "Please connect the AnimationPlayer");
        }

        @Method @Rename("button_toggled") buttonToggled() {
                if (cond) {
                        anim.play("off");
                        cond = false;
                } else {
                        anim.play("on");
                        cond = true;
                }
        }
}
