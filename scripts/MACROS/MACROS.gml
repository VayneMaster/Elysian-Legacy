//--Macros
#macro SKILL_COUNT 14
#macro SKILL_POINTS_START 1
#macro SKILL_POINTS_PER_MISSION 3
#macro TARGET_FPS 60
#macro SAVE_FILE_NAME "LEW_campaign.sav"
#macro SAVE_VERSION 1

global.camera_setup = 0;
//cam enunm
enum CameraSetup {
	TITLE = 0,
	BATTLEFIELD = 1
}

//Game enums?
enum Team {
    PLAYER = 0,
    ENEMY = 1
}

enum GameState { 
    PLAYING,
    VICTORY,
    DEFEAT 
}


enum UnitState {
	MOVING,
	ATTACKING
}

//--Skill tree enums
enum SkillBranch {
    MELEE = 0,
    RANGED = 1,
    ELITE = 2
}

enum SkillID {
    // MELEE
    M1 = 0,
    M2 = 1,
    M3 = 2,
    M4 = 3,
    M5 = 4,

    // RANGED
    R1 = 5,
    R2 = 6,
    R3 = 7,
    R4 = 8,
    R5 = 9,

    // ELITE
    E1 = 10,
    E2 = 11,
    E3 = 12,
    E4 = 13
}

//SPECIALS
enum SpecialID {
    ROCKS,
    SPEARS,
    IRON,
    MODERN,
    LASER,
    LIGHTNING,
    COUNT
}

//pause pages
enum PausePage {
	MAIN = 0,
	SETTINGS = 1,
	QUIT = 2,
	CONFIRM_MENU = 3,
	CONFIRM_DESKTOP = 4,
	CONFIRM_RESTART = 5
}

//build mode tab
enum BuildTab {
	UNITS = 0,
	TURRETS = 1
}

//title
enum TitlePage {
	MAIN = 0,
	OPTIONS = 1,
	INFO = 2
}

enum MissionID {
	M1_STONE_VS_GREEK, //0 stone vs greek
	M2_IRON_AGE, //after learning
	M3_GREEK_VS_MODERN, //Greek vs modern
	M4_MODERN_VS_MODERN, //Modern vs modern
	M5_PORTAL_DEFENSE, // defend cons
	M6_ZEUS_FINAL_BATTLE, //5 final
	COUNT
}

enum CutsceneID {
	INTRO, //intro
	GREEK_KNOWLEDGE, //after m1 learning
	MODERN_DISCOVERY, //Modern day dig
	PORTAL_CREATION, //portal built
	LEARN_MODERN_TECH, //after m3 learning modern weps
	PORTAL_ENTRY, //ENTER portal
	ZEUS_WARNING, //zeuss warning
	COUNT
}

enum ObjectiveType {
	DESTROY_ENEMY_BASE, //standard enemy base destroy
	SURVIVE_TIME, //survive for x seconds
	DEFEND_STRUCTURE, //keep strcut alive
	LOSE_INTENTIONALLY, //player is ment to lose
	DEFEAT_BOSS, //boos battle
}

enum CampaignState {
	NOT_STARTED,
	IN_PROGRESS,
	MISSION_COMPLETE,
	MISSION_FAILED,
	CUTSCENE_PLAYING,
	CAMPAIGN_COMPLETE
}

//tech eras for units
enum TechEra {
	STONE_AGE,
	IRON_AGE,
	GREEK_CLASSICAL,
	MODERN,
	ADVANCED,
	MYTHOLOGICAL
}
