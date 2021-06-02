#importonce

.label CharSetTarget            = $2000
.label CharSetSource            = $8E00

.label SCREEN_RAM               = $0400
.label SCREEN_RAM_END           = $0800
.label COLOUR_RAM               = $D800
.label COLOUR_RAM_OFFSET        = $D400

.label ScreenRowLoByte          = $0340
.label ScreenRowHiByte          = $0360

.label ScreenRow                = $03
.label ScreenColumn             = $02

.label ScreenCharacter          = $04
.label ScreenCharColour         = $05

.label ScreenLocationLo         = $06
.label ScreenLocationHi         = $07

.label ShipColumn               = $0B
.label ShipRow                  = $0C
.label MasterTimer              = $0D

.label FiringTimer              = $0F
// #$05 = Laser Firing
// #$00 = Player Buller Firing

.label BulletColumn             = $10
.label BulletRow                = $11
.label BulletCharacter          = $12

.label OuterGridShipTimer       = $14
.label VerticalShipRow          = $15
.label HorizontalShipColumn     = $16
.label OutShipFiringTimer       = $17

.label LaserActiveFlag          = $18
// #$FF = Active, #$00 Not Active
.label CurrentLaserChar         = $19
.label LaserRow                 = $1A
.label LaserCurrentCol          = $1B
.label LaserCol                 = $1C
.label LaserCurrentRow          = $1D

.label BombDecayZPLo            = $1F
.label BombDecayZPHi            = $20
.label BombTimer                = $21

.label PODSfxTimer              = $22
.label PODSfxLoopCounter        = $23

.label NoOfActiveSnakes         = $24
.label SnakeMasterTimer         = $25
.label SnakeHeadCharacter       = $26
.label CurrentSnakeIndex        = $27


.label SnakeTimer               = $28
.label NumberofSnakeChars       = $29
.label NoOfSnakesForLevel       = $2A
.label LevelSnakeLength         = $2B
.label ExplosionCharacter       = $2D

.label JoystickInput            = $0E

.label CurrentSIDVolumnLevel    = $33
.label LevelLaserFiringReset    = $34
.label CurrentLevelNumber       = $35
.label NoOfLives                = $0427
.label ScoreBoard               = $040E
.label HiScoreBoard             = $041A

.label BombScrnLocLo            = $1000
.label BombScrnLocHi            = $1020

.label SnakeArrayCol            = $1100
.label SnakeArrayRow            = $1200
.label SnakeArrayControl        = $1300

.label ShipColExplosionArr      = $1500
.label ShipRowExplosionArr      = $1600

// Characeters
.const VerticalSHIP             = $01
.const HorizontalSHIP           = $02
.const SHIPCharacter            = $07
.const SHIPLaser1Character      = $08
.const SHIPLaser2Character      = $09
.const GRIDCharacter            = $00
.const SPACECharacter           = $20
.const PODCharacter             = $0F
.const PODBombCharacter         = $0A
.const PODRebornCharacter       = $12

.const EXPLOSION_ANI_START      = $16
.const EXPLOSION_ANI_END        = $19
.const SNAKE_ANI_START          = $13
.const SNAKE_ANI_END            = $16
.const BULLET_ANI_START         = $08
.const BULLET_ANI_END           = $09
.const VERT_LASER_ANI_START     = $05
.const VERT_LASER_ANI_END       = $06

.const GRIDVerticalBar          = $3F

// JoyStick
.const joyFIRE                  = %00010000
.const joyRIGHT                 = %00001000
.const joyLEFT                  = %00000100
.const joyDOWN                  = %00000010
.const joyUP                    = %00000001

// Colours 
.const GRIDColour               = $08
.const PLAYERColour             = $01
.const SHIPColour               = $0D
.const BULLETColour             = $01
.const HorzAndVertShipColour    = $01
.const LaserColour              = $01
.const PODColour                = $07
.const PODBombColour            = $01
.const SnakeColour              = $03
.const ExplosionColourStart     = $08
.const ExplosionColour          = $01
.const BattleStationColour      = $0E
.const EnteringGridAreaColour   = $01
.const ByJeffMinterColour       = $03
.const EnterLevelColour         = $01


// GAME CONSTANTS
.const COLOUR_OFFSET_HI         = $D4

.const SCREEN_ROW_LENGTH        = $28
.const SCREEN_MAX_ROWS          = $18
.const MATRIX_ROW_SIZE          = $15
.const MATRIX_COL_SIZE          = $26
.const MATRIX_TOP_ROW           = $03
.const MATRIX_SHIP_TOP_ROW      = $0D
.const MATRIX_BOTTOM_ROW        = $15
.const MATRIX_FIRST_COL         = $01
.const MATRIX_LAST_COL          = $26

.const MAX_NUMBER_OF_LEVELS     = $20

.label CurrentLevelDigit1       = $0558
.label CurrentLevelDigit2       = CurrentLevelDigit1 - 1

.label EnteringGridAreaDigit1   = $055F
.label EnteringGridAreaDigit2   = EnteringGridAreaDigit1 - 1
.label EnteringGridAreaColour1  = EnteringGridAreaDigit1 + COLOUR_RAM_OFFSET
.label EnteringGridAreaColour2  = EnteringGridAreaDigit2 + COLOUR_RAM_OFFSET

.label CopyRightScreenLoc       = $0592
.label CopyRightColourLoc       = CopyRightScreenLoc + COLOUR_RAM_OFFSET
.label BattleStationScreenLoc   = $04FD
.label BattleStationColourLoc   = BattleStationScreenLoc + COLOUR_RAM_OFFSET
.label EnteringGridAreaScreenLoc= $054D
.label EnteringGridAreaColourLoc= EnteringGridAreaScreenLoc + COLOUR_RAM_OFFSET

.label ByJeffMinterScreenLoc    = $04FA
.label ByJeffMinterColourLoc    = ByJeffMinterScreenLoc + COLOUR_RAM_OFFSET

.label EnterLevelScreenLoc      = $054A
.label EnterLevelColourLoc      = EnterLevelScreenLoc + COLOUR_RAM_OFFSET

.label PODDecayStartLocation    = $0450

