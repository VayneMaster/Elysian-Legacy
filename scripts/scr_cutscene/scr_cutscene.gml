function scr_get_cutscene_config(_cutscene_id){
    var config = {};
    config.scenes = [];
    
    switch(_cutscene_id) {
        case CutsceneID.INTRO:
            config.scenes = [
                { 
                    text: @"What if, but just what if, everything we know from history seems to be...
                    I can't talk about this, they will know, they will know and come for us.
                    We must maintain our livelyhood!",
                    duration: 12,
                    background_color: make_colour_rgb(40, 30, 20)
                },
                {
                    text: @"They know!
                    Someone must have told them!
                    They will come, they will come.. Come with their impossible weaponry.",
                    duration: 8,
                    background_color: make_colour_rgb(40, 30, 20)
                },
                {
                    text: @"Here they come!
                    They wield weapons of unknown material, tactics like generations of elders.
                    We stand no chance!
                    There is no way, we must fight!
                    Fight and master their crafts!
                    Prevail!",
                    duration: 13,
                    background_color: make_colour_rgb(40, 30, 20)
                }
            ];
            break;
            
        case CutsceneID.GREEK_KNOWLEDGE:
            config.scenes = [
                {
                    text: @"We are victorious, but something is off.
                    Because why?
                    Why are we not defeated despite their superiority?",
                    duration: 10,
                    background_color: make_colour_rgb(40, 30, 20)
                },
                {
                    text: @"The Elders found an odd looking rock, it looks like it fits somewhere.
                    We should dedicate all to unravel the mysteries behind all the happenings.",
                    duration: 9,
                    background_color: make_colour_rgb(50, 40, 30)
                },
                {
                    text: @"And thus the Elders retreated deep inside the cave, to never be seen again.
                    For generations to come, those designated as Elders will follow their footsteps.
                    Every couple of decades the Elders supply us with newfound knowledge.
                    We quickly learned about bronze and shortly thereafter... iron.",
                    duration: 16,
                    background_color: make_colour_rgb(35, 35, 40)
                },
                {
                    text: @"How are they so advanced, yet they didn't know how to use it?
                    There are centuries of information stored inside this rock, but that isn't its purpose.
                    What is it!? Why does it feel like we're being watched!?
                    Is there something we shouldn't know?",
                    duration: 16,
                    background_color: make_colour_rgb(30, 30, 35)
                }
            ];
            break;
                
        case CutsceneID.MODERN_DISCOVERY:
            config.scenes = [
                {
                    text: @"Thanks to the knowledge of the Elders, we have mastered iron.
                    Still, our counterparts across the world are not as advanced.
                    These secrets must be contained.
                    We cannot defend ourselves against the entire world...",
                    duration: 14,
                    background_color: make_colour_rgb(40, 30, 20)
                },
                {
                    text: @"CENTURIES LATER...",
                    duration: 3,
                    background_color: make_colour_rgb(20, 20, 25)
                },
                {
                    text: @"We have prospered in secret.
                    Our civilization rivals the ancient Greeks in knowledge.
                    The stone continues to whisper its secrets.
                    But we sense... something is coming.",
                    duration: 12,
                    background_color: make_colour_rgb(45, 40, 35)
                },
                {
                    text: @"A PORTAL OPENS IN THE SKY",
                    duration: 3,
                    background_color: make_colour_rgb(60, 50, 80)
                },
                {
                    text: @"Soldiers emerge... wearing strange armor, wielding weapons of light and thunder.
                    They speak a language we somehow... understand?
                    They demand the stone.
                    They call it 'The Artifact.'
                    How do they know!?",
                    duration: 16,
                    background_color: make_colour_rgb(50, 40, 50)
                }
            ];
            break;
            
        case CutsceneID.PORTAL_CREATION:
            // This cutscene is skipped - goes straight to LEARN_MODERN_TECH
            config.scenes = [];
            break;
            
        case CutsceneID.LEARN_MODERN_TECH:
            config.scenes = [
                {
                    text: @"The battle was brutal. Overwhelming.
                    Their technology... impossible.
                    But we held the line.",
                    duration: 10,
                    background_color: make_colour_rgb(50, 40, 40)
                },
                {
                    text: @"As their portal destabilized, they fled back through it.
                    They left behind... everything.
                    Weapons. Armor. Strange glowing devices.",
                    duration: 12,
                    background_color: make_colour_rgb(45, 45, 50)
                },
                {
                    text: @"The Elders studied the artifacts for days without rest.
                    And then... they understood.
                    These soldiers... they came from the FUTURE.
                    OUR future.",
                    duration: 14,
                    background_color: make_colour_rgb(40, 40, 55)
                },
                {
                    text: @"That feeling of familiarity... we've fought them before.
                    Or... we WILL fight them before?
                    Time is not what we thought it was.
                    The stone... it doesn't just store knowledge.
                    It bends TIME itself.",
                    duration: 16,
                    background_color: make_colour_rgb(50, 45, 60)
                },
                {
                    text: @"With their technology and our stone...
                    We can master their weapons.
                    We can fight as equals.
                    We will take the fight to THEM.",
                    duration: 12,
                    background_color: make_colour_rgb(60, 50, 50)
                }
            ];
            break;
            
        case CutsceneID.PORTAL_ENTRY:
            config.scenes = [
                {
                    text: @"VICTORY!
                    The invaders have been pushed back!",
                    duration: 5,
                    background_color: make_colour_rgb(40, 60, 40)
                },
                {
                    text: @"The Elders have deciphered their portal technology.
                    Combined with the stone's power...
                    We can create our own gateway through time.",
                    duration: 12,
                    background_color: make_colour_rgb(50, 50, 70)
                },
                {
                    text: @"But the portal is unstable.
                    It flickers. It hungers for energy.
                    We need materials from their time to stabilize it.",
                    duration: 12,
                    background_color: make_colour_rgb(55, 45, 75)
                },
                {
                    text: @"The Elders speak of a great risk:
                    'To travel through time is to invite the gaze of the gods.
                    They who watch over the threads of fate
                    will not look kindly upon those who pull at them.'",
                    duration: 16,
                    background_color: make_colour_rgb(45, 40, 65)
                },
                {
                    text: @"We have no choice.
                    Through the unstable portal...
                    We march into the future.
                    To claim what we need.
                    To secure our destiny.",
                    duration: 14,
                    background_color: make_colour_rgb(70, 60, 90)
                },
                {
                    text: @"THE PORTAL OPENS...",
                    duration: 4,
                    background_color: make_colour_rgb(90, 80, 120)
                }
            ];
            break;
            
        case CutsceneID.ZEUS_WARNING:
            config.scenes = [
                {
                    text: @"FINAL VICTORY!
                    The materials are ours!
                    The portal can be stabilized!",
                    duration: 8,
                    background_color: make_colour_rgb(70, 60, 40)
                },
                {
                    text: @"The Elders work through the night.
                    The stone glows brighter than ever before.
                    The portal... it's perfect.
                    Stable. Eternal.
                    A gateway to any time. Any place.",
                    duration: 16,
                    background_color: make_colour_rgb(60, 50, 80)
                },
                {
                    text: @"But as the final piece locks into place...
                    The sky tears open.
                    Lightning crashes down.
                    A voice booms across the heavens:",
                    duration: 12,
                    background_color: make_colour_rgb(50, 50, 70)
                },
                {
                    text: @"'MORTALS! YOU DARE DEFY THE NATURAL ORDER!?'",
                    duration: 5,
                    background_color: make_colour_rgb(90, 80, 100)
                },
                {
                    text: @"ZEUS himself descends from Olympus.
                    His army of monsters and mythological beasts at his back.
                    'This power was never meant for human hands!
                    I will SHATTER your portal and ERASE your blasphemy!'",
                    duration: 16,
                    background_color: make_colour_rgb(80, 70, 90)
                },
                {
                    text: @"The final battle begins...",
                    duration: 4,
                    background_color: make_colour_rgb(70, 60, 80)
                },
                {
                    text: @"---AFTER THE BATTLE---",
                    duration: 3,
                    background_color: make_colour_rgb(30, 30, 40)
                },
                {
                    text: @"Zeus falls.
                    The gods... defeated.
                    The portal stands complete.
                    We have won.",
                    duration: 10,
                    background_color: make_colour_rgb(40, 50, 60)
                },
                {
                    text: @"But with his dying breath, Zeus speaks:
                    'You fools... you know not what you have done.
                    This power... it is a CURSE, not a gift.'",
                    duration: 12,
                    background_color: make_colour_rgb(50, 45, 55)
                },
                {
                    text: @"'Every time you activate this portal...
                    Time will COLLAPSE upon itself.
                    You will be thrown back to the beginning.
                    Doomed to repeat this cycle... FOREVER.'",
                    duration: 16,
                    background_color: make_colour_rgb(60, 50, 60)
                },
                {
                    text: @"'You will remember nothing... yet feel everything.
                    That familiarity you felt with the soldiers?
                    You have fought them a THOUSAND times.
                    You have built this portal a THOUSAND times.
                    You have defeated me... a THOUSAND times.'",
                    duration: 20,
                    background_color: make_colour_rgb(50, 40, 60)
                },
                {
                    text: @"'And you will do it all again.
                    And again.
                    And again.
                    Such is the fate of those who defy the gods.'",
                    duration: 14,
                    background_color: make_colour_rgb(40, 35, 50)
                },
                {
                    text: @"Zeus fades into dust.
                    The Elders look at each other with horror.
                    One whispers: 'I've... I've seen this before. Haven't I?'
                    Another: 'We need to warn... ourselves? Our past selves?'",
                    duration: 16,
                    background_color: make_colour_rgb(45, 40, 55)
                },
                {
                    text: @"But it's too late.
                    The portal activates.
                    Reality begins to shimmer.
                    The world... RESETS.",
                    duration: 10,
                    background_color: make_colour_rgb(70, 60, 90)
                },
                {
                    text: @"---SOMEWHERE, SOMEWHEN---",
                    duration: 4,
                    background_color: make_colour_rgb(20, 20, 25)
                },
                {
                    text: @"An Elder sits by a fire, writing on parchment:
                    'What if, but just what if, everything we know from history seems to be...
                    I can't talk about this, they will know, they will know and come for us.
                    We must maintain our livelyhood!'",
                    duration: 16,
                    background_color: make_colour_rgb(40, 30, 20)
                },
                {
                    text: @"THE CYCLE CONTINUES...",
                    duration: 5,
                    background_color: make_colour_rgb(30, 30, 40)
                },
                {
                    text: @"TO BE CONTINUED...?
                    OR HAS IT ALREADY BEGUN AGAIN?",
                    duration: 6,
                    background_color: make_colour_rgb(20, 20, 30)
                }
            ];
            break;
            
        default:
            config.scenes = [
                {
                    text: "ERROR: Cutscene not found",
                    duration: 2,
                    background_color: c_red
                }
            ];
            break;
    }
    
    return config;
}

function scr_play_cutscene(_cutscene_id) {
	if (!instance_exists(oCutscenePlayer)) {
		var player = instance_create_depth(0,0, -10000, oCutscenePlayer);
		player.cutscene_id = _cutscene_id;
		player.cutscene_config = scr_get_cutscene_config(_cutscene_id);
		return player;
	}
	return noone;
}
