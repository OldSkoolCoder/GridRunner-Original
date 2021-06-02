*= $8000

#import "Constants.asm"
#import "C64Constants.asm"

CopyCharSet:
    ldx #$00
//------------------------------
//L_BRS_8002_800F
//------------------------------
!CharacterCopyLooper:
    lda CharSetSource,x         // Copy Char Set to New Location
    sta CharSetTarget,x         // Store in Bank 0
    lda CharSetSource + $0100,x 
    sta CharSetTarget + $0100,x 
    dex 
    bne !CharacterCopyLooper-   //L_BRS_8002_800F
    jmp SetupVICChip            // L_jmp_821B_8011

    nop 
//------------------------------
//L_jmp_8015_806A:
//------------------------------
HiScoreLooper:
    inx 
    cpx #$07
    bne ScoreBoardTestLoop      // L_BRS_8062_8018
    jmp DisplayByJeffMinter     // L_jmp_8D8E_801A

    nop 
    nop 
    nop 
//------------------------------
// L_jsr_8020_868D:
//------------------------------
CheckForShipImpact:
    jsr GetCharacterFromScreenLocation          // L_jsr_818B_8020
    cmp #SHIPCharacter
    beq !PlayerDetected+                     // L_BRS_8028_8025
    rts 
//------------------------------
// L_BRS_8028_8025:
//------------------------------
!PlayerDetected:
    jmp ResetTheStack                       // L_jmp_8ADE_8028
    nop 
    nop 
    nop 
    nop 
    nop 
//------------------------------
// L_jmp_8030_805C:
//------------------------------
CheckRowIsStillOnGrid:
    and #$1F
    cmp #SCREEN_MAX_ROWS
    bpl !ExplosionOffGrid+          // L_BRS_803A_8034
//------------------------------
// L_jmp_8036_803C:
//------------------------------
!ExplosionStillWithinBounds:
    sta ShipRowExplosionArr,x 
    rts 
//------------------------------
// L_BRS_803A_8034:
//------------------------------
!ExplosionOffGrid:
    lda ShipRow 
    jmp !ExplosionStillWithinBounds-        // L_jmp_8036_803C
    nop 
//------------------------------
// L_jsr_8040_8B7F:
//------------------------------
CalculatingExplosionCol:
    dec ShipColExplosionArr,x 
    lda ShipColExplosionArr,x 
    and #$3F
    cmp #SCREEN_ROW_LENGTH - 1
    bpl !ResetToShipCol+            // L_BRS_8050_804A
    sta ShipColExplosionArr,x 
    rts 
//------------------------------
// L_BRS_8050_804A:
//------------------------------
!ResetToShipCol:
    lda ShipColumn 
    sta ShipColExplosionArr,x 
    rts 
//------------------------------
//L_jsr_8056_8B91:
//------------------------------
CalculatingExplosionRow:
    dec ShipRowExplosionArr,x 
    lda ShipRowExplosionArr,x 
    jmp CheckRowIsStillOnGrid           // L_jmp_8030_805C
    nop 
//------------------------------
// L_jmp_8060_8C2A:
//------------------------------
HiScoreTest:
    ldx #$00
//------------------------------
// L_BRS_8062_8018:
//------------------------------
ScoreBoardTestLoop:
    lda ScoreBoard + 1,x 
    cmp HiScoreBoard + 1 ,x 
    bne !HiScoreNotTheSame+         // L_BRS_8070_8068
    jmp HiScoreLooper               // L_jmp_8015_806A
//------------------------------
// L_BRS_806D_8070:
//------------------------------
!NotAHiScore:
    jmp DisplayByJeffMinter     // L_jmp_8D8E_806D
//------------------------------
// L_BRS_8070_8068:
//------------------------------
!HiScoreNotTheSame:
    bmi !NotAHiScore-           // L_BRS_806D_8070
//------------------------------
// L_BRS_8072_807B:
//------------------------------
!CopyScoreToHiScoreLoop:
    lda ScoreBoard + 1,x 
    sta HiScoreBoard + 1,x 
    inx 
    cpx #$07
    bne !CopyScoreToHiScoreLoop-    // L_BRS_8072_807B
    jmp DisplayByJeffMinter     // L_jmp_8D8E_807D

//*=$8080
CopyRightandFire:
    .byte $3C,$3D,$20,$3E,$3E,$28,$2D,$28,$2F,$30,$2A,$3A,$20,$2E,$22,$27
//*=$8090
    .byte $2F,$2F,$20,$2A,$24,$22,$27,$20,$3A,$30,$20,$29,$27,$21,$24,$26
//------------------------------
// L_jsr_80A0_8DC0:
//------------------------------
DisplayLevelNumber:
    lda CurrentLevelNumber
    cmp #MAX_NUMBER_OF_LEVELS       // Max 20 Levels
    bne !NotHitMaxLevels+
    lda #$01
    sta CurrentLevelNumber                     // Level Number
//L_BRS_80AA_80A4:
!NotHitMaxLevels:
    lda #$30
    sta CurrentLevelDigit2
    sta CurrentLevelDigit1
    ldx CurrentLevelNumber 
//------------------------------
// L_BRS_80B4_80C7:
//------------------------------
IncreaseCurrentDisplayLevel:
    inc CurrentLevelDigit1
    lda CurrentLevelDigit1
    cmp #$3A
    bne !ByPass+                // L_BRS_80C6_80BC
    lda #$30
    sta CurrentLevelDigit1
    inc CurrentLevelDigit2
//------------------------------
// L_BRS_80C6_80BC:
//------------------------------
!ByPass:
    dex 
    bne IncreaseCurrentDisplayLevel     // L_BRS_80B4_80C7
    ldx #$30
//------------------------------
//L_BRS_80CB_80CF:
//------------------------------
!DelayLooper:
    jsr TwoStage256Delay    // L_jsr_8386_80CB
    dex 
    bne !DelayLooper-       // L_BRS_80CB_80CF
    rts 
//------------------------------
//L_jmp_80D2_8DAD:
//------------------------------
DisplayCopyRight:
    ldx #$20
//------------------------------
//L_BRS_80D4_80E0:
//------------------------------
!CharacterLooper:
    lda CopyRightandFire,x  // Copyright Lamasoft
    sta CopyRightScreenLoc,x// Press Fire To start
    lda #$07
    sta CopyRightColourLoc,x// Yellow
    dex 
    bne !CharacterLooper-   // L_BRS_80D4_80E0
    jmp LevelSelection      // L_jmp_8DC0_80E2
//------------------------------
// L_jmp_80E5_8DC8:
//------------------------------
BeginGame:
    lda #$34
    sta NoOfLives 
    ldx #$07
    lda #$30
//------------------------------
// L_BRS_80EE_80F2:
//------------------------------
!ClearNextScoreDigit:
    sta ScoreBoard,x 
    dex 
    bne !ClearNextScoreDigit-   //L_BRS_80EE_80F2
    jmp DisplayBattleStations   // L_jmp_8C2D_80F4
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
//------------------------------
// L_jmp_8100_822D:
//------------------------------
SetUpSIDChip:
    // lda #$00    // Black
    // sta $D021   // Set Border
    // sta EXTCOL   // Set Background
    // lda #$16    // Video Bank $0400 : Character Bank $1800
    // sta VMCSB   // Set Up Video and Character Bank
    lda #>VIC_SP0X
    sta ScreenRow 
    lda #$00
    sta ScreenColumn 
    ldy #$18
    tya 
    sta ($02),y // store $18 in VMCSB 
    ldy #$20
    lda #$00
    sta ($02),y // Store $00 in EXTCOL
    iny 
    sta ($02),y // Store $00 in $D021

    lda #$0A
    sta SID_FREHI1   // Set Hi Freq Voice 1
    sta SID_ATDCY1   // Set Att/dec Voice 1
    sta SID_ATDCY2   // Set Att/dec Voice 2 
    lda #$00
    sta SID_SUREL1   // Voice 1 Sus/Rel
    sta SID_SUREL2   // Voice 2 Sus/Rel
    lda #$05     
    sta SID_FREHI2   // Set Hi Freq Voice 2

    ldx #$00
    lda #$00
    sta ScreenColumn 
    lda #$04
    sta ScreenRow 
//------------------------------
//L_BRS_8138_815D:
//------------------------------
// Clear Screen Routine
ClearScreen:
    lda ScreenColumn 
    sta ScreenRowLoByte,x             // Lo Byte Screen Row Table 
    lda ScreenRow 
    sta ScreenRowHiByte,x             // Hi Byte Screen Row Table

// Clear the screen
    ldy #$00
    lda #$20
//------------------------------
//L_BRS_8146_814B
//------------------------------
!RowCharLooper:
    sta ($02),y // Set Top Row to Space
    iny 
    cpy #SCREEN_ROW_LENGTH    // Loop back Round
    bne !RowCharLooper- //L_BRS_8146_814B
    lda ScreenColumn 
    clc 
    adc #SCREEN_ROW_LENGTH    // Add 40 for next Row
    sta ScreenColumn 
    lda ScreenRow 
    adc #$00
    sta ScreenRow 
    inx 
    cpx #SCREEN_MAX_ROWS
    bne ClearScreen             //L_BRS_8138_815D
    jmp L_jmp_8818_815F
    rts 
//------------------------------
// L_jsr_8163_8172:
// L_jsr_8163_818B:
//------------------------------
GetCurrentScreenLineAddress:
    ldx ScreenRow                 // Get Row
    ldy ScreenColumn 
    lda ScreenRowLoByte,x   // Row Lo Byte 
    sta ScreenLocationLo 
    lda ScreenRowHiByte,x   // Row Hi Byte
    sta ScreenLocationHi 
    rts 
//------------------------------
// L_jsr_8172_81C4:
// L_jsr_8172_81F9:
// L_jsr_8172_827D:
// L_jsr_8172_8287:
// L_jsr_8172_8291:
// L_jsr_8172_8298:
// L_jsr_8172_82A1:
// L_jsr_8172_82C4:
// L_jsr_8172_82CE:
// L_jsr_8172_82D8:
// L_jsr_8172_82DF:
// L_jsr_8172_8400:
// L_jsr_8172_842A:
// L_jsr_8172_8492:
// L_jmp_8172_84F5:
// L_jsr_8172_8540:
// L_jmp_8172_8570:
// L_jsr_8172_85B6:
// L_jsr_8172_85D1:
// L_jmp_8172_85FA:
// L_jsr_8172_85FD:
// L_jsr_8172_8662:
// L_jsr_8172_8684:
// L_jmp_8172_869F:
// L_jsr_8172_86B2:
// L_jmp_8172_86CD:
// L_jsr_8172_87F8:
// L_jmp_8172_8803:
// L_jsr_8172_8921:
// L_jsr_8172_897C:
// L_jmp_8172_899C:
// L_jmp_8172_8A77:
// L_jmp_8172_8ADB:
// L_jsr_8172_8B50:
// L_jsr_8172_8BAB:
// L_jsr_8172_8D88:
//------------------------------
SetCharAndColourAtXY:
    // Store Character and Colour
    jsr GetCurrentScreenLineAddress         // L_jsr_8163_8172     // Get Current Line Address
    lda ScreenCharacter 
    sta (ScreenLocationLo),y 
    lda ScreenLocationHi 
    clc 
    adc #COLOUR_OFFSET_HI                // Adds Colour Ram Offset
    sta ScreenLocationHi 
    //------------------------------------------
    // Why
    lda ScreenLocationHi 
    lda ScreenLocationHi 
    sta ScreenLocationHi 
    // End Why
    //------------------------------------------

    lda ScreenCharColour 
    sta (ScreenLocationLo),y 
    rts 
//------------------------------
// L_jsr_818B_8020:
// L_jsr_818B_8480:
// L_jsr_818B_84DD:
// L_jsr_818B_852A:
// L_jsr_818B_8560:
// L_jsr_818B_8675:
// L_jsr_818B_8937:
// L_jsr_818B_8AD4:
// L_jsr_818B_8B49:
// L_jmp_818B_8BBD:
//------------------------------
GetCharacterFromScreenLocation:
    jsr GetCurrentScreenLineAddress         // L_jsr_8163_818B
    lda (ScreenLocationLo),y 
    rts 
//------------------------------
// L_jsr_8191_0A02:
// L_jsr_8191_0A37:
// L_jsr_8191_81C7:
// L_jsr_8191_81FC:
//------------------------------
SetNoiseForVoc1Voc2:
    lda #$00
    sta SID_VCREG1               // Turn Voice 1 off
    sta SID_VCREG2               // Turn Voice Two Off
    lda #$81
    sta SID_VCREG1               // Configure Voice 1 and 2
    sta SID_VCREG2               // Enabled, Noise
    rts 
//------------------------------
// L_jsr_81A2_8314:
//------------------------------
ScrnGridBuilding:
    lda #$02                // Column Number
    sta $08 
    lda #GRIDColour         // Character Colour
    sta ScreenCharColour 
    lda #GRIDVerticalBar    // Character For Screen
    sta ScreenCharacter 
//------------------------------
// L_BRS_81AE_81E3:
//------------------------------
!OuterColumnLoop:
    lda #$00
    sta SID_VCREG3 
    lda #$00                // Turn Voice 3 off
    sta SID_VCREG3 
    lda #$02                // Row Number
    sta $09 
//------------------------------
// L_BRS_81BC_81D0:
//------------------------------
!ColumnLineDrawingLoop:
    lda $09 
    sta ScreenRow                 // Copy Column
    lda $08 
    sta ScreenColumn                 // Copy Row 
    jsr SetCharAndColourAtXY    // L_jsr_8172_81C4
    jsr SetNoiseForVoc1Voc2
    inc $09 
    lda $09 
    cmp #MATRIX_BOTTOM_ROW + 1
    bne !ColumnLineDrawingLoop- // L_BRS_81BC_81D0
    ldx #$01
//------------------------------
// L_BRS_81D4_81DB:
//------------------------------
!DumpSFXLooper:
    jsr IReleventDumpSFXJmp     // L_jsr_8230_81D4
    dey 
    bne L_BRS_81DA_81D8         // OSK : Potential Bug
//------------------------------
L_BRS_81DA_81D8:
//------------------------------
    dex 
    bne !DumpSFXLooper-         // L_BRS_81D4_81DB
    inc $08 
    lda $08 
    cmp #$27
    bne !OuterColumnLoop-       // L_BRS_81AE_81E3
    lda #$02
    sta $08 
    lda #GRIDCharacter
    sta ScreenCharacter 
//------------------------------
// L_BRS_81ED_8218:
//------------------------------
!OuterRowLoop:
    lda #$01
    sta $09 
//------------------------------
// L_BRS_81F1_8205:
//------------------------------
!RowLineDrawingLoop:
    lda $09 
    sta ScreenColumn 
    lda $08 
    sta ScreenRow 
    jsr SetCharAndColourAtXY    // L_jsr_8172_81F9
    // Why
    jsr SetNoiseForVoc1Voc2
    inc $09 
    lda $09 
    cmp #MATRIX_LAST_COL + 1
    bne !RowLineDrawingLoop-        // L_BRS_81F1_8205
    // jsr SetNoiseForVoc1Voc2      // --> OSK Addition
    ldx #$01
//------------------------------
//L_BRS_8209_8210:
//------------------------------
!DumpSFXLooper:
    jsr IReleventDumpSFXJmp     // L_jsr_8230_8209
    // jsr DumpSFX              // --> OSK Addition
    dey 
    bne L_BRS_820F_820D         // Potential Bug : OSK
//------------------------------
L_BRS_820F_820D:
//------------------------------
    dex 
    bne !DumpSFXLooper-         // L_BRS_8209_8210
    inc $08 
    lda $08 
    cmp #MATRIX_BOTTOM_ROW + 1
    bne !OuterRowLoop-          // L_BRS_81ED_8218
    rts 
//------------------------------
// L_jmp_821B_8011:
//------------------------------
SetupVICChip:
    lda #$34    
    sta $0314           // alter IRQ to not Do RunStop Test ($EA34)
    lda #$00            // Black
    sta VIC_BGCOL0      // Set Border
    sta VIC_EXTCOL      // Set Background
    lda #%00010110      // $16 = Video Bank $0400 : Character Bank $1800
    sta VIC_VMCSB       // Set Up Video and Character Bank
    jmp SetUpSIDChip            // L_jmp_8100_822D
//------------------------------
// L_jsr_8230_81D4:
// L_jsr_8230_8209:
IReleventDumpSFXJmp:
//------------------------------
    //------------------------------------------
    // Why ?
    jmp DumpSFX     // L_jmp_8233_8230
    //------------------------------------------

//------------------------------
// L_jmp_8233_8230:
DumpSFX:
//------------------------------
    lda #$04
    sta $0A 
//------------------------------
// L_jmp_8237_824C:
DumpSFXSpecial:
//------------------------------
    inc $0A 
    lda $0A 
    cmp #$04
    bne !PerformDumpSFX+    // L_BRS_8240_823D
    rts 
//------------------------------
// L_BRS_8240_823D:
//------------------------------
!PerformDumpSFX:
    lda $08 
    sta SID_FREHI1 
    lda $08 
    adc #$01
    sta SID_FREHI2 
    jmp DumpSFXSpecial      // L_jmp_8237_824C
//------------------------------
// L_jsr_824F_8317:
//------------------------------
ShipMaterialisation:
    lda #$0F
    sta $0A 
    lda #$02
    sta SID_FREHI2 
    lda #$00
    sta SID_VCREG1 
    sta SID_VCREG2 
    lda #EXPLOSION_ANI_START
    sta ScreenCharacter 
//------------------------------
// L_jmp_8264_8417:
//------------------------------
MaterialiseShip:
    lda #PLAYERColour
    sta ScreenCharColour 
    lda #$00
    sta SID_VCREG2 
    lda #$81
    sta SID_VCREG2 
    // Lower Left Meterialisation Org
    lda #MATRIX_ROW_SIZE 
    sta ScreenRow 
    lda #$14
    clc 
    sbc $0A 
    sta ScreenColumn            // Lower Left Corner
    jsr SetCharAndColourAtXY    // L_jsr_8172_827D
    // Lower Right Meterialisation Org
    lda #$14
    clc 
    adc $0A 
    sta ScreenColumn            // Lower Right Corner
    jsr SetCharAndColourAtXY    // L_jsr_8172_8287
    // Upper Left Meterialisation Org
    lda ScreenRow 
    clc 
    sbc $0A 
    sta ScreenRow               // Upper Right Corner
    jsr SetCharAndColourAtXY    // L_jsr_8172_8291
    lda #$14
    sta ScreenColumn            // Upper Central
    jsr SetCharAndColourAtXY    // L_jsr_8172_8298
    lda #$14
    sbc $0A 
    sta ScreenColumn            // Upper Left Corner
    jsr SetCharAndColourAtXY    // L_jsr_8172_82A1
    inc ScreenCharacter 
    lda ScreenCharacter         // Loop Tru Chars $16 -> $19
    cmp #EXPLOSION_ANI_END
    bne !ResetMaterialisationChar+      // L_BRS_82AE_82AA
    lda #EXPLOSION_ANI_START
//------------------------------
// L_BRS_82AE_82AA:
//------------------------------
!ResetMaterialisationChar:
    sta $09 
    ldx $0A 
//------------------------------
// L_BRS_82B2_82B6:
//------------------------------
!SoundDelayLoop:
    jsr DelayRoutine                // L_jsr_8380_82B2
    dex 
    bne !SoundDelayLoop-            // L_BRS_82B2_82B6

    // Reset Characters back To Grid Character
    lda #GRIDCharacter
    sta ScreenCharacter 
    lda #GRIDColour
    sta ScreenCharColour 
    lda #$14
    sta ScreenColumn 
    jsr SetCharAndColourAtXY    // L_jsr_8172_82C4
    lda #$14
    clc 
    sbc $0A 
    sta ScreenColumn 
    jsr SetCharAndColourAtXY    // L_jsr_8172_82CE
    lda #$14
    clc 
    adc $0A 
    sta ScreenColumn 
    jsr SetCharAndColourAtXY    // L_jsr_8172_82D8
    lda #MATRIX_ROW_SIZE
    sta ScreenRow 
    jsr SetCharAndColourAtXY    // L_jsr_8172_82DF
    lda #$14
    clc 
    sbc $0A 
    sta ScreenColumn 
    jmp ShipMaterialisationLoop  // L_jmp_8400_82E9
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
//------------------------------
// L_jmp_8300_8D4F:
//------------------------------
GameActivation:
    lda #$0F
    sta SID_SIGVOL 
    lda #$A0
    sta SID_FREHI3 
    lda #$04
    sta SID_ATDCY3 
    lda #$00
    sta SID_SUREL3 
    jsr ScrnGridBuilding // L_jsr_81A2_8314
    jsr ShipMaterialisation     // L_jsr_824F_8317

    lda #(SCREEN_ROW_LENGTH / 2) 
    sta ShipColumn 
    lda #MATRIX_BOTTOM_ROW
    sta ShipRow 
    lda #$FF
    sta BulletRow 
    lda #$01
    sta HorizontalShipColumn 
    lda #$02
    sta VerticalShipRow 
    lda #$04
    sta OuterGridShipTimer 
    lda #$0A
    sta OutShipFiringTimer 
    sta SID_ATDCY3
    sta LaserActiveFlag 
    jsr ClearBombArray              // L_jsr_8748_833B
    lda #$00
    sta PODSfxTimer 
    sta PODSfxLoopCounter 
    sta NoOfActiveSnakes 
    lda #SNAKE_ANI_START
    sta SnakeHeadCharacter 
    lda #$20
    sta SnakeTimer 
    lda LevelSnakeLength 
    sta LevelSnakeLength 
    sta LevelSnakeLength             //// Why ? 
    lda NoOfSnakesForLevel 
    sta NoOfSnakesForLevel 
    lda #$00
    sta NumberofSnakeChars 
    lda #$0F
    sta SID_SIGVOL 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    jmp MainGameLoop                // L_jmp_83A0_8370
//------------------------------
// L_jsr_8373_8475:
//------------------------------
JoystickCapture:
    //lda $DC11 
    lda CIAPRB + $10
    eor #$FF
    sta JoystickInput 
    rts 
//------------------------------
    nop 
    nop 
    nop 
    nop 
    nop 
//------------------------------
// L_jsr_8380_82B2:
// L_jsr_8380_8465:
//------------------------------
DelayRoutine:
    lda $0A 
    cmp #$00
    beq !LoopEnd+   // L_BRS_8392_8384
//------------------------------
//L_jsr_8386_80CB:
//L_jsr_8386_8BD9:
//------------------------------
TwoStage256Delay:
    lda #$00
//------------------------------
// L_jmp_8388_8D54:
//------------------------------
TwoStageDelay:
    sta $30 
//------------------------------
//L_BRS_838A_838C:
//------------------------------
!DelayLoopOne:
    dec $30 
    bne !DelayLoopOne- // L_BRS_838A_838C
//------------------------------
//L_BRS_838E_8390:
//------------------------------
!DelayLoopPartTwo:
    dec $30 
    bne !DelayLoopPartTwo-  //L_BRS_838E_8390
//------------------------------
//L_BRS_8392_8384:
//------------------------------
!LoopEnd:
    rts 
//------------------------------
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
//------------------------------
// L_jmp_83A0_8370:
// L_jmp_83A0_83FA:
//------------------------------
MainGameLoop:
    jsr GameControls                // L_jsr_8470_83A0
    jsr FireControl                 // L_jsr_84F8_83A3
    jsr GridEdgeShipsControl        // L_jsr_859B_83A6
    jsr LaserControl                // L_jsr_8635_83A9
    jsr PODDecayControl             // L_jsr_86D7_83AC
    jsr BombControl                 // L_jsr_8753_83AF
    jsr PODDestructionSfx           // L_jsr_889A_83B2
    jsr SnakeControl                // L_jsr_88C9_83B5
    jsr MasterTimerReset            // L_jsr_89A0_83B8
    jsr LevelCompletedControl       // L_jsr_8AC8_83BB
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    nop 
    jmp MainGameLoop                // L_jmp_83A0_8370
    nop 
    nop 
    nop 
//------------------------------
// L_jmp_8400_82E9:
//------------------------------
ShipMaterialisationLoop:
    jsr SetCharAndColourAtXY    // L_jsr_8172_8400
    lda $09 
    sta ScreenCharacter 
    dec $0A 
    lda $0A 
    cmp #$FF
    beq !ShipPlacement+  // L_BRS_841A_840D
    lda #$0F
    clc 
    sbc $0A 
    sta SID_SIGVOL 
    jmp MaterialiseShip         // L_jmp_8264_8417
//------------------------------
// L_BRS_841A_840D:
//------------------------------
!ShipPlacement:
    lda #SHIPCharacter
    sta ScreenCharacter 
    lda #SHIPColour
    sta ScreenCharColour 
    lda #MATRIX_BOTTOM_ROW
    sta ScreenRow 
    lda #(SCREEN_ROW_LENGTH / 2)  
    sta ScreenColumn 
    jsr SetCharAndColourAtXY    // L_jsr_8172_842A

    // Ship Materialised Sound Effect
    lda #$0F
    sta SID_SIGVOL 
    jsr WibbleWobbleSFX         // L_jsr_8450_8432
    lda #$08
    sta SID_SIGVOL 
    jsr WibbleWobbleSFX         // L_jsr_8450_843A
    lda #$02
    sta SID_SIGVOL 
    jsr WibbleWobbleSFX         // L_jsr_8450_8442
    lda #$00
    sta SID_VCREG2 
    lda #$0F
    sta SID_SIGVOL 
    rts 
//------------------------------
// L_jsr_8450_8432:
// L_jsr_8450_843A:
// L_jsr_8450_8442:
//------------------------------
WibbleWobbleSFX:
    lda #$18
    sta $0A 
//------------------------------
//L_BRS_8454_846D:
//------------------------------
!OuterDelayLoop:
    lda $0A 
    sta SID_FREHI2 
    lda #$00
    sta SID_VCREG2 
    lda #$11
    sta SID_VCREG2 
    ldx #$02
//------------------------------
// L_BRS_8465_8469:
//------------------------------
!InnerDelayLoop:
    jsr DelayRoutine            // L_jsr_8380_8465
    dex 
    bne !InnerDelayLoop-        // L_BRS_8465_8469
    dec $0A 
    bne !OuterDelayLoop-        // L_BRS_8454_846D
    rts 
//------------------------------
// L_jsr_8470_83A0:
//------------------------------
GameControls:
    dec MasterTimer                         // Equivalent to Raster Check
    beq !CheckControls+             // L_BRS_8475_8472
    
    rts 
//------------------------------
// L_BRS_8475_8472:
//------------------------------
!CheckControls:
    jsr JoystickCapture                         // L_jsr_8373_8475
    lda ShipColumn 
    sta ScreenColumn 
    lda ShipRow 
    sta ScreenRow 
    jsr GetCharacterFromScreenLocation          // L_jsr_818B_8020
    cmp #SHIPCharacter
    beq ShipStillIntacked                       // L_BRS_848A_8485
    jsr IsFriendlyFireInShipSpot                      // L_jsr_8BEC_8487
//------------------------------
// L_BRS_848A_8485:
//------------------------------
ShipStillIntacked:
    lda #GRIDCharacter
    sta ScreenCharacter 
    lda #GRIDColour
    sta ScreenCharColour 
    jsr SetCharAndColourAtXY    // L_jsr_8172_8492
    lda JoystickInput 
    and #joyUP                  // #$01 : Test For Down
    beq !TestForDown+           // L_BRS_84A7_8499
    dec ScreenRow 
    lda ScreenRow 
    cmp #MATRIX_SHIP_TOP_ROW - 1// Test For Upper Limit
    bne !TestForDown+           // L_BRS_84A7_84A1
    lda #MATRIX_SHIP_TOP_ROW    // Reset back
    sta ScreenRow 
//------------------------------
// L_BRS_84A7_8499:
// L_BRS_84A7_84A1:
//------------------------------
!TestForDown:
    lda JoystickInput 
    and #joyDOWN                // #$02
    beq !TestForLeft+           // L_BRS_84B9_84AB
    inc ScreenRow 
    lda ScreenRow 
    cmp #MATRIX_BOTTOM_ROW + 1  // Test For off Grid
    bne !TestForLeft+           // L_BRS_84B9_84B3
    lda #MATRIX_BOTTOM_ROW      // Reset To Bottom Row
    sta ScreenRow 
//------------------------------
// L_BRS_84B9_84AB:
// L_BRS_84B9_84B3:
//------------------------------
!TestForLeft:
    lda JoystickInput 
    and #joyLEFT                // #$04
    beq !TestForRight+          // L_BRS_84CB_84BD
    dec ScreenColumn 
    lda ScreenColumn 
    cmp #MATRIX_FIRST_COL - 1   // Test For Left Limit
    bne !TestForRight+          // L_BRS_84CB_84C5
    lda #MATRIX_FIRST_COL       // Reset For Left Most Column
    sta ScreenColumn 
//------------------------------
// L_BRS_84CB_84BD:
// L_BRS_84CB_84C5:
//------------------------------
!TestForRight:
    lda JoystickInput 
    and #joyRIGHT               // #$08
    beq !CheckCurrentLocation+   // L_BRS_84DD_84CF
    inc ScreenColumn 
    lda ScreenColumn 
    cmp #MATRIX_LAST_COL + 1    // Test Right Limit
    bne !CheckCurrentLocation+   // L_BRS_84DD_84D7
    lda #MATRIX_LAST_COL        // Reset To RightMost Column
    sta ScreenColumn 
//------------------------------
// L_BRS_84DD_84CF:
// L_BRS_84DD_84D7:
//------------------------------
!CheckCurrentLocation:
    jsr GetCharacterFromScreenLocation          // L_jsr_818B_8020
    beq !ShipOkToMove+                          // L_BRS_84E5_84E0
    jsr IsPODisShipsSpot                        // L_jsr_89AB_84E2
//------------------------------
// L_BRS_84E5_84E0:
//------------------------------
!ShipOkToMove:
    lda ScreenColumn 
    sta ShipColumn 
    lda ScreenRow 
    sta ShipRow 
    lda #SHIPColour
    sta ScreenCharColour 
    lda #SHIPCharacter
    sta ScreenCharacter 
    jmp SetCharAndColourAtXY    // L_jmp_8172_84F5
//------------------------------
// L_jsr_84F8_83A3:
//------------------------------
FireControl:
    dec FiringTimer 
    beq FireBullet              // L_BRS_84FD_84FA
//------------------------------
// L_BRS_84FC_850E:
//------------------------------
!FireButtonNotPresses:
    rts 
//------------------------------
// L_BRS_84FD_84FA:
//------------------------------
FireBullet:
    lda #$18
    sta FiringTimer 
    jsr BulletSFx           // L_jsr_8573_8501
    lda BulletRow 
    cmp #$FF
    bne !WhatsUnderTheBullet+               // L_BRS_8522_8508
    lda JoystickInput 
    and #joyFIRE            // $10
    beq !FireButtonNotPresses-      // L_BRS_84FC_850E
    lda ShipColumn 
    sta BulletColumn 
    lda ShipRow 
    sta BulletRow 
    dec BulletRow 
    lda #BULLET_ANI_START      // Intial Bullet State
    sta BulletCharacter 
    lda #$40
    sta $13 
//------------------------------
// L_BRS_8522_8508:
//------------------------------
!WhatsUnderTheBullet:
    lda BulletColumn 
    sta ScreenColumn 
    lda BulletRow 
    sta ScreenRow 
    jsr GetCharacterFromScreenLocation          // L_jsr_818B_8020
    cmp BulletCharacter 
    beq !SomethingWasUnderneath+                // L_BRS_8538_852F
    cmp #GRIDCharacter
    beq !SomethingWasUnderneath+               // L_BRS_8538_8533
    jsr CheckForPODs                    //L_jsr_87CB_8535
//------------------------------
// L_BRS_8538_852F:
// L_BRS_8538_8533:
//------------------------------
!SomethingWasUnderneath:
    lda #GRIDColour
    sta ScreenCharColour 
    lda #GRIDCharacter
    sta ScreenCharacter 
    jsr SetCharAndColourAtXY    // L_jsr_8172_8540
    inc BulletCharacter 
    lda BulletCharacter 
    cmp #$0A                    // Test For Bomb
    bne !NormalBulletTravel+    // L_BRS_855C_8549
    dec BulletRow 
    lda BulletRow 
    cmp #$02                    // Test For Top Of Grid
    bne !ResetBullet+           // L_BRS_8558_8551
    lda #$FF
    sta BulletRow 
    rts 
//------------------------------
// L_BRS_8558_8551:
//------------------------------
!ResetBullet:
    lda #BULLET_ANI_START
    sta BulletCharacter 
//------------------------------
// L_BRS_855C_8549:
//------------------------------
!NormalBulletTravel:
    lda BulletRow 
    sta ScreenRow 
    jsr GetCharacterFromScreenLocation          // L_jsr_818B_8020
    beq !GridCharacterFound+                    // L_BRS_8568_8563
    jsr CheckForPODs                    // L_jsr_87CB_8565
//------------------------------
// L_BRS_8568_8563:
//------------------------------
!GridCharacterFound:
    lda BulletCharacter 
    sta ScreenCharacter 
    lda #BULLETColour
    sta ScreenCharColour 
    jmp SetCharAndColourAtXY    // L_jmp_8172_8570
//------------------------------
// L_jsr_8573_8501:
//------------------------------
BulletSFx:
    lda $13 
    bne !ActionBulletSfx+        // L_BRS_8578_8575
    rts 
//------------------------------
// L_BRS_8578_8575:
//------------------------------
!ActionBulletSfx:
    dec $13 
    lda $13 
    adc #$00            // OSK : Why ?
    sta SID_FREHI1 
    lda #$00
    sta SID_VCREG1 
    lda #$81
    sta SID_VCREG1 
    lda $13 
    sta SID_FREHI2 
    lda #$00
    sta SID_VCREG2 
    lda #$81
    sta SID_VCREG2 
    rts 
//------------------------------
//L_jsr_859B_83A6:    // OSK : Possible GridShips
//------------------------------
GridEdgeShipsControl:
    lda MasterTimer 
    cmp #$01
    beq WorkOutNewVerticalShipPosition      // L_BRS_85A2_859F
//------------------------------
// L_BRS_85A1_85A4:
//------------------------------
!Exit:
    rts 
//------------------------------
// L_BRS_85A2_859F:
//------------------------------
WorkOutNewVerticalShipPosition:
    dec OuterGridShipTimer 
    bne !Exit-                  // L_BRS_85A1_85A4
    lda #$02
    sta OuterGridShipTimer 
    lda #$00
    sta ScreenColumn 
    lda VerticalShipRow 
    sta ScreenRow 
    lda #SPACECharacter
    sta ScreenCharacter 
    jsr SetCharAndColourAtXY    // L_jmp_8172_8570
    inc VerticalShipRow 
    lda VerticalShipRow 
    cmp #MATRIX_BOTTOM_ROW + 1
    bne !NotOffTheGridVertically+  // L_BRS_85C5_85BF
    lda #MATRIX_TOP_ROW
    sta VerticalShipRow 
//------------------------------
// L_BRS_85C5_85BF:
//------------------------------
!NotOffTheGridVertically:
    lda VerticalShipRow 
    sta ScreenRow 
    lda #HorzAndVertShipColour
    sta ScreenCharColour 
    lda #VerticalSHIP
    sta ScreenCharacter 
    jsr SetCharAndColourAtXY    // L_jmp_8172_8570

!WorkOutNewHorizontalShipPosition:
    lda #MATRIX_BOTTOM_ROW + 1
    sta ScreenRow 
    lda HorizontalShipColumn 
    sta ScreenColumn 
    lda #SPACECharacter
    jsr StoreCharacterOnScreenAtPos // L_jsr_85F8_85DE
    inc HorizontalShipColumn 
    lda HorizontalShipColumn 
    cmp #MATRIX_LAST_COL + 1
    bne !NotOffTheGridHorizontally+ // L_BRS_85ED_85E7 
    lda #MATRIX_FIRST_COL
    sta HorizontalShipColumn 
//------------------------------
// L_BRS_85ED_85E7:
//------------------------------
!NotOffTheGridHorizontally:
    lda HorizontalShipColumn 
    sta ScreenColumn 
    lda #HorizontalSHIP
    sta ScreenCharacter 
    jmp !PlaceHorizonalShip+    // L_jmp_85FD_85F5
//------------------------------
// L_jsr_85F8_85DE:
//------------------------------
StoreCharacterOnScreenAtPos:
    sta ScreenCharacter 
    jmp SetCharAndColourAtXY    // L_jmp_8172_8570
//------------------------------
// L_jmp_85FD_85F5:
//------------------------------
!PlaceHorizonalShip:
    jsr SetCharAndColourAtXY    // L_jmp_8172_8570
    dec OutShipFiringTimer 
    beq !FireLaser+             // L_BRS_8605_8602
    rts 
//------------------------------
// L_BRS_8605_8602:
//------------------------------
!FireLaser:
    lda LevelLaserFiringReset 
    sta OutShipFiringTimer 
    jsr !FireLaserSndFq+       // L_jsr_862F_8609
    lda #$00
    sta SID_VCREG3 
    lda #$21
    sta SID_VCREG3 
    lda #$FF
    sta LaserActiveFlag 
    lda #VERT_LASER_ANI_START
    sta CurrentLaserChar 
    lda VerticalShipRow 
    sta LaserRow 
    lda #$01
    sta LaserCurrentCol 
    lda #$15
    sta LaserCurrentRow 
    lda HorizontalShipColumn 
    sta LaserCol 
    rts 
//------------------------------
// L_jsr_862F_8609:
//------------------------------
!FireLaserSndFq:
    lda #$03
    sta SID_FREHI3 
    rts 
//------------------------------
// L_jsr_8635_83A9:
//------------------------------
LaserControl:
    lda FiringTimer 
    cmp #$05
    beq !ExecuteLaser+              // L_BRS_863C_8639
//------------------------------
// L_BRS_863B_8640:
//------------------------------
!Exit:
    rts 
//------------------------------
// L_BRS_863C_8639:
//------------------------------
!ExecuteLaser:
    lda LaserActiveFlag 
    cmp #$FF
    bne !Exit-                      // L_BRS_863B_8640
    jsr ChangeLaserCharacter        // L_jsr_86D0_8642
    nop 
    cmp #$07
    bne !Continue+                  // L_BRS_864E_8648
    // Reset Current Character
    lda #VERT_LASER_ANI_START
    sta CurrentLaserChar 
//------------------------------
// L_BRS_864E_8648:
//------------------------------
!Continue:
    lda #LaserColour
    sta ScreenCharColour 
    lda CurrentLaserChar 
    sta ScreenCharacter 
    lda #MATRIX_BOTTOM_ROW
    sta LaserCurrentRow 
//------------------------------
// L_BRS_865A_866B:
//------------------------------
!VerticalLaserDraw:
    lda LaserCurrentRow 
    sta ScreenRow 
    lda LaserCol 
    sta ScreenColumn 
    jsr SetCharAndColourAtXY    // L_jmp_8172_8570
    dec LaserCurrentRow 
    lda LaserCurrentRow 
    cmp #MATRIX_TOP_ROW - 1
    bne !VerticalLaserDraw-     // L_BRS_865A_866B
    lda LaserRow 
    sta ScreenRow 
    lda LaserCurrentCol                 // = 1 First Row.... same as colour value
    sta ScreenColumn 
    jsr GetCharacterFromScreenLocation          // L_jsr_818B_8020
    cmp CurrentLaserChar 
    beq !DetectedLaser+                 // L_BRS_86A2_867A
    lda #GRIDCharacter
    sta ScreenCharacter 
    lda #SHIPLaser1Character
    sta ScreenCharColour 
    jsr SetCharAndColourAtXY    // L_jmp_8172_8570
    inc LaserCurrentCol 
    lda LaserCurrentCol 
    sta ScreenColumn 
    jsr CheckForShipImpact       // L_jsr_8020_868D
    cmp CurrentLaserChar 
    beq !DetectedLaser+         // L_BRS_86A2_8692
    lda #LaserColour
    sta ScreenCharColour 
    lda CurrentLaserChar 
    clc 
    sbc #$01
    sta ScreenCharacter 
    jmp SetCharAndColourAtXY    // L_jmp_8172_8570
//------------------------------
// L_BRS_86A2_867A:
// L_BRS_86A2_8692:
//------------------------------
!DetectedLaser:
    lda #MATRIX_BOTTOM_ROW
    sta ScreenRow 
    lda LaserCol 
    sta ScreenColumn 
    lda #GRIDColour
    sta ScreenCharColour 
    lda #GRIDCharacter
    sta ScreenCharacter 
//------------------------------
// L_BRS_86B2_86BB:
//------------------------------
!ClearOutVerticalLaser:
    jsr SetCharAndColourAtXY    // L_jmp_8172_8570
    dec ScreenRow 
    lda ScreenRow 
    cmp #MATRIX_TOP_ROW - 1
    bne !ClearOutVerticalLaser-     // L_BRS_86B2_86BB
    lda LaserRow 
    sta ScreenRow 
    lda #PODColour
    sta ScreenCharColour 
    lda #PODCharacter
    sta ScreenCharacter 
    lda #$00
    sta LaserActiveFlag 
    jmp SetCharAndColourAtXY    // L_jmp_8172_8570
//------------------------------
// L_jsr_86D0_8642:
//------------------------------
ChangeLaserCharacter:
    dec FiringTimer 
    inc CurrentLaserChar 
    lda CurrentLaserChar 
    rts 
//------------------------------
// L_jsr_86D7_83AC:
//------------------------------
PODDecayControl:
    lda OutShipFiringTimer 
    cmp #$05
    beq ExecutePODDecay            // L_BRS_86DE_86DB
    rts 
//------------------------------
// L_BRS_86DE_86DB:
//------------------------------
ExecutePODDecay:
    dec OutShipFiringTimer 
    lda #>PODDecayStartLocation
    sta BombDecayZPHi 
    lda #<PODDecayStartLocation
    sta BombDecayZPLo 
    ldy #$00
//------------------------------
// L_BRS_86EA_86F0:
// L_BRS_86EA_86F8:
//------------------------------
!LoadPODLocation:
    lda (BombDecayZPLo),y 
    bne !CheckingForPODs+              // L_BRS_86FB_86EC
//------------------------------
// L_BRS_86EE_86FD:
// L_jmp_86EE_8709:
// L_jmp_86EE_8716:
// L_jmp_86EE_871C:
//------------------------------
!ContinuePODLocating:
    inc BombDecayZPLo 
    bne !LoadPODLocation-               // L_BRS_86EA_86F0
    inc BombDecayZPHi 
    lda BombDecayZPHi 
    cmp #>SCREEN_RAM_END
    bne !LoadPODLocation-               // L_BRS_86EA_86F8
    rts 
//------------------------------
// L_BRS_86FB_86EC:
//------------------------------
!CheckingForPODs:
    cmp #SPACECharacter
    beq !ContinuePODLocating-       // L_BRS_86EE_86FD
    ldx #$07
//------------------------------
// L_BRS_8701_8707:
//------------------------------
!PODCharacterChecker:
    //cmp $871F,x 
    cmp PODCharacters,x
    beq !PODCharFound+              // L_BRS_870C_8704
    dex 
    bne !PODCharacterChecker-       // L_BRS_8701_8707
    jmp !ContinuePODLocating-       // L_jmp_86EE_8709
//------------------------------
// L_BRS_870C_8704:
//------------------------------
!PODCharFound:
    cpx #$07
    beq !PODHasDecayed+                // L_BRS_8719_870E
    inx 
    //lda $871F,x 
    lda PODCharacters,x
    sta (BombDecayZPLo),y 
    jmp !ContinuePODLocating-       // L_jmp_86EE_8716
//------------------------------
// L_BRS_8719_870E:
//------------------------------
!PODHasDecayed:
    jsr SettingUpPODBomb            // L_jsr_8728_8719
    jmp !ContinuePODLocating-       // L_jmp_86EE_871C

// *=$871F
PODCharacters:
    nop 
    .byte $18,$0D,$0E,$0F,$10,$11,$12,$13
//------------------------------
// L_jsr_8728_8719:
//------------------------------
SettingUpPODBomb:
    lda #PODBombCharacter
    sta (BombDecayZPLo),y 
    ldx #$18            // <<<< - is this the max = No Of Rows
//------------------------------
// L_BRS_872E_8736:
//------------------------------
!LoopThruBombArray:
    //lda $101F,x 
    lda BombScrnLocHi-1,x
    cmp #$FF
    beq !EmptyBombSlot+         // L_BRS_873D_8733
    dex 
    bne !LoopThruBombArray-     // L_BRS_872E_8736
    lda #PODRebornCharacter
    sta (BombDecayZPLo),y 
    rts 
//------------------------------
// L_BRS_873D_8733:
//------------------------------
!EmptyBombSlot:
    lda BombDecayZPLo 
    //sta $0FFF,x 
    sta BombScrnLocLo-1,x
    lda BombDecayZPHi 
    //sta $101F,x 
    sta BombScrnLocHi-1,x
    rts 
//------------------------------
// L_jsr_8748_833B:
//------------------------------
ClearBombArray:
    ldx #SPACECharacter
    lda #$FF
//------------------------------
// L_BRS_874C_8750:
//------------------------------
!ClearBombLoop:
    //sta $101F,x 
    sta BombScrnLocHi-1,x
    dex 
    bne !ClearBombLoop-             // L_BRS_874C_8750
    rts 
//------------------------------
// L_jsr_8753_83AF:
//------------------------------
BombControl:
    dec BombTimer 
    beq !UpdateBombs+           // L_BRS_8758_8755
    rts 
//------------------------------
// L_BRS_8758_8755:
//------------------------------
!UpdateBombs:
    lda #$40
    sta BombTimer 
    ldx #$18
//------------------------------
// L_BRS_875E_8769:
//------------------------------
!UpdateBombLooper:
    //lda $101F,x 
    lda BombScrnLocHi-1,x
    cmp #$FF
    beq !EmptyBombSlot+             // L_BRS_8768_8763
    jsr UpdateBomb                  // L_jsr_876C_8765
//------------------------------
// L_BRS_8768_8763:
//------------------------------
!EmptyBombSlot:
    dex 
    bne !UpdateBombLooper-          // L_BRS_875E_8769
    rts 
//------------------------------
// L_jsr_876C_8765:
//------------------------------
UpdateBomb:
    //lda $0FFF,x 
    lda BombScrnLocLo-1,x
    sta ScreenColumn 
    //lda $101F,x 
    lda BombScrnLocHi-1,x
    sta ScreenRow 
    ldy #$00
    lda ($02),y 
    cmp #$07
    bne !ShipNotDestroyed+              // L_BRS_8781_877C
    jmp ResetTheStack                   // L_jmp_8ADE_877E
//------------------------------
// L_BRS_8781_877C:
//------------------------------
!ShipNotDestroyed:
    lda #GRIDCharacter
    sta ($02),y 
    lda ScreenRow 
    clc 
    adc #COLOUR_OFFSET_HI
    sta ScreenRow 
    lda #GRIDColour
    sta ($02),y 
    //lda $0FFF,x 
    lda BombScrnLocLo-1,x
    clc 
    adc #SCREEN_ROW_LENGTH
    //sta $0FFF,x 
    sta BombScrnLocLo-1,x
    //lda $101F,x 
    lda BombScrnLocHi-1,x
    adc #$00
    //sta $101F,x 
    sta BombScrnLocHi-1,x
    sta ScreenRow 
    //lda $0FFF,x 
    lda BombScrnLocLo-1,x
    sta ScreenColumn 
    lda ($02),y 
    cmp #SPACECharacter
    bne !CheckForPlayer+                 // L_BRS_87B4_87AC
    lda #$FF
    //sta $101F,x 
    sta BombScrnLocHi-1,x
    rts 
//------------------------------
// L_BRS_87B4_87AC:
//------------------------------
!CheckForPlayer:
    cmp #SHIPCharacter
    bne !NotPlayer+                     // L_BRS_87BB_87B6
    jmp ResetTheStack                   // L_jmp_8ADE_87B8
//------------------------------
// L_BRS_87BB_87B6:
//------------------------------
!NotPlayer:
    lda #PODBombCharacter
    sta ($02),y 
    lda ScreenRow 
    clc 
    adc #COLOUR_OFFSET_HI
    sta ScreenRow 
    lda #PODBombColour
    sta ($02),y 
    rts 
//------------------------------
// L_jsr_87CB_8535:
// L_jsr_87CB_8565:
//------------------------------
CheckForPODs:
    ldx #$07
//------------------------------
// L_BRS_87CD_87D3:
//------------------------------
!TestForNextPOD:
    //cmp $871F,x 
    cmp PODCharacters,x
    beq !PODCharacterDetected+      // L_BRS_87D9_87D0
    dex 
    bne !TestForNextPOD-            // L_BRS_87CD_87D3
    jmp CheckForSnake               // L_jmp_8A11_87D5
    rts // OSK : Why ?
//------------------------------
// L_BRS_87D9_87D0:
//------------------------------
!PODCharacterDetected:
    dex 
    beq !PODDestroyed+              // L_BRS_87EC_87DA
    // lda $871F,x 
    lda PODCharacters,x
    sta ScreenCharacter 
    lda #PODColour
    sta ScreenCharColour 
    lda #$FF
    sta BulletRow 
    jmp !PlaceNewPOD+                // L_jmp_8801_87E9
//------------------------------
// L_BRS_87EC_87DA:
//------------------------------
!PODDestroyed:
    lda #GRIDCharacter
    sta ScreenCharacter 
    lda #GRIDColour
    sta ScreenCharColour 
    lda #$FF
    sta BulletRow 
    jsr SetCharAndColourAtXY    // L_jmp_8172_8570
    jsr AddPODScore             // L_jsr_888A_87FB
    pla 
    pla 
    rts 
//------------------------------
// L_jmp_8801_87E9:
//------------------------------
!PlaceNewPOD:
    pla 
    pla 
    jmp SetCharAndColourAtXY    // L_jmp_8172_8570
//------------------------------
L_jsr_8806_8818:
//------------------------------
// Top Row Configuration
    ldx #SCREEN_ROW_LENGTH
//------------------------------
!CharacterLooper:
// L_BRS_8808_8815:
//------------------------------
//  TODO : Sort this out
    lda TopRowConfiguration -1,x 
    sta SCREEN_RAM - 1,x 
    lda TopRowConfigurationColour - 1,x 
    sta COLOUR_RAM - 1,x 
    dex 
    bne !CharacterLooper-   // L_BRS_8808_8815
    rts 
//------------------------------
L_jmp_8818_815F:
//------------------------------
    jsr L_jsr_8806_8818
    jmp L_jmp_8D57_881B
    nop 
    nop 
// *=$8820
TopRowConfiguration:
    .byte $21,$22,$24,$25,$22,$23,$26,$26,$27,$22,$20,$20,$19,$1A,$20,$30
    .byte $30,$30,$30,$30,$30,$30,$20,$20,$1D,$1E,$20,$30,$30,$30,$30,$30
    .byte $30,$30,$20,$20,$07,$20,$20,$34

TopRowConfigurationColour:
    .byte $03,$03,$03,$03,$04,$04,$04,$04,$04,$04,$01,$01,$07,$07,$01,$03
    .byte $03,$03,$03,$03,$03,$03,$01,$01,$07,$07,$01,$0E,$0E,$0E,$0E,$0E
    .byte $0E,$0E,$01,$01,$0D,$01,$01,$04
//------------------------------
// L_BRS_8870_8887:
// L_jsr_8870_888E:
// L_jsr_8870_8A25:
// L_jmp_8870_8AA1:
//------------------------------
UpdateScore:
// X = Start Digit to Increase 1's 10's 100's
// Y = how many times E.g. 10 
    txa 
    pha 
//------------------------------
// L_BRS_8872_8882:
//------------------------------
!UpdateScoreDigit:
    inc ScoreBoard + 1,x 
    lda ScoreBoard + 1,x 
    cmp #$3A
    bne !UpdateDigitSuccessful+     // L_BRS_8884_887A
    lda #$30
    sta ScoreBoard + 1,x 
    dex 
    bne !UpdateScoreDigit-          // L_BRS_8872_8882
//------------------------------
// L_BRS_8884_887A:
//------------------------------
!UpdateDigitSuccessful:
    pla 
    tax 
    dey 
    bne UpdateScore                 // L_BRS_8870_8887
    rts 
//------------------------------
// L_jsr_888A_87FB:
//------------------------------
AddPODScore:
    ldx #$06
    ldy #$0A
    jsr UpdateScore                 // L_jsr_8870_888E
    lda #$F0
    sta PODSfxTimer 
    lda #$03
    sta PODSfxLoopCounter 
//------------------------------
// L_BRS_8899_889E:
//------------------------------
!AddPODScoreExit:
    rts 
//------------------------------
// L_jsr_889A_83B2:
//------------------------------
PODDestructionSfx:
    lda MasterTimer 
    and #$01
    beq !AddPODScoreExit-           // L_BRS_8899_889E
    lda PODSfxTimer 
    and #$C0
    beq !ResetPODSfxCounter+         // L_BRS_88B8_88A4
    dec PODSfxTimer 
    lda PODSfxTimer 
    sta SID_FREHI3 
    lda #$00
    sta SID_VCREG3 
    lda #$21
    sta SID_VCREG3 
    rts 
//------------------------------
// L_BRS_88B8_88A4:
//------------------------------
!ResetPODSfxCounter:
    lda PODSfxLoopCounter 
    beq !PODDestructionSfxEnd+         // L_BRS_88C3_88BA
    dec PODSfxLoopCounter 
    lda #$F0
    sta PODSfxTimer 
    rts 
//------------------------------
// L_BRS_88C3_88BA:
//------------------------------
!PODDestructionSfxEnd:
    lda #$04
    sta SID_FREHI3 
    rts 
//------------------------------
// L_jsr_88C9_83B5:
//------------------------------
SnakeControl:
    dec SnakeMasterTimer 
    beq !ProcessSnake+              // L_BRS_88CE_88CB
//------------------------------
// L_BRS_88CD_88D7:
//------------------------------
!ExitSnakeControl:
    rts 
//------------------------------
// L_BRS_88CE_88CB:
//------------------------------
!ProcessSnake:
    lda #$80
    sta SnakeMasterTimer 
    jsr InsertingNewSnake           // L_jsr_89C1_88D2
    lda NoOfActiveSnakes 
    beq !ExitSnakeControl-          // L_BRS_88CD_88D7
    tax 
    inc SnakeHeadCharacter 
    lda SnakeHeadCharacter 
    cmp #SNAKE_ANI_END
    bne !ByPassSnakeHeadCharReset+  // L_BRS_88E6_88E0
    lda #SNAKE_ANI_START
    sta SnakeHeadCharacter 
//------------------------------
// L_BRS_88E6_88E0:
// L_BRS_88E6_8927:
//------------------------------
!ByPassSnakeHeadCharReset:
    stx CurrentSnakeIndex 
    lda SnakeArrayCol - 1,x 
    sta ScreenColumn 
    lda SnakeArrayRow - 1,x 
    sta ScreenRow 
    lda #GRIDCharacter
    sta ScreenCharacter 
    lda #GRIDColour
    sta ScreenCharColour 
    jsr SnakeDisplayRoutine             // L_jsr_8995_88FA
    ldx CurrentSnakeIndex 
    lda SnakeArrayControl - 1,x 
    and #$40
    bne !ItIsSnakeBody+             // L_BRS_892A_8904
    lda SnakeArrayCol - 2,x 
    sta SnakeArrayCol - 1,x 
    lda SnakeArrayRow - 2,x 
    sta SnakeArrayRow - 1,x 
    sta ScreenRow 
    lda SnakeArrayCol - 1,x 
    sta ScreenColumn 
    lda #SnakeColour
    sta ScreenCharColour 
    lda #SNAKE_ANI_START
    sta ScreenCharacter 
    jsr SetCharAndColourAtXY    // L_jmp_8172_8570
//------------------------------
// L_jmp_8924_8981:
//------------------------------
!CycleTruSnakeArray:
    ldx CurrentSnakeIndex 
    dex 
    bne !ByPassSnakeHeadCharReset-      // L_BRS_88E6_8927
    rts 
//------------------------------
// L_BRS_892A_8904:
//------------------------------
!ItIsSnakeBody:
    lda SnakeArrayControl - 1,x 
    and #$02
    bne !IsGoingLeft+               // L_BRS_8935_892F
    inc ScreenColumn 
    inc ScreenColumn 
//------------------------------
// L_BRS_8935_892F:
//------------------------------
!IsGoingLeft:
    dec ScreenColumn 
    jsr GetCharacterFromScreenLocation          // L_jsr_818B_8020
    beq !SnakeOkToMove+             // L_BRS_8990_893A
    ldx CurrentSnakeIndex 
    jsr HaveWeEatenPlayerShip       // L_jsr_8AE9_893E
    sta ScreenColumn 
    inc ScreenRow 
    lda ScreenRow 
    cmp #MATRIX_BOTTOM_ROW + 1
    bne !NotHitBottomOfGrid+        // L_BRS_8962_8949
    lda SnakeArrayControl - 1,x 
    ora #$01
    and #$FD
    sta SnakeArrayControl - 1,x 
    lda #MATRIX_SHIP_TOP_ROW + 1
    sta.abs ScreenRow
    lda #$02
    sta.abs ScreenColumn
    jmp !PlaceSnakeCharOnGrid+              // L_jmp_896A_895F
//------------------------------
// L_BRS_8962_8949:
//------------------------------
!NotHitBottomOfGrid:
    lda SnakeArrayControl - 1,x 
    eor #$03
    sta SnakeArrayControl - 1,x 
//------------------------------
// L_jmp_896A_895F:
// L_jmp_896A_8992:
//------------------------------
!PlaceSnakeCharOnGrid:
    lda ScreenColumn 
    sta SnakeArrayCol - 1,x 
    lda ScreenRow 
    sta SnakeArrayRow - 1,x 
    lda #SnakeColour
    sta ScreenCharColour 
    lda SnakeHeadCharacter 
    sta ScreenCharacter 
    jsr SetCharAndColourAtXY    // L_jmp_8172_8570
    ldx CurrentSnakeIndex 
    jmp !CycleTruSnakeArray-    // L_jmp_8924_8981
    ldx #$01
    inc SnakeHeadCharacter 
    rts 
//------------------------------
    ldx CurrentSnakeIndex 
    inx 
    cpx NoOfActiveSnakes 
    rts 
//------------------------------
    nop 
//------------------------------
// L_BRS_8990_893A:
//------------------------------
!SnakeOkToMove:
    ldx CurrentSnakeIndex 
    jmp !PlaceSnakeCharOnGrid-      // L_jmp_896A_8992
//------------------------------
// L_jsr_8995_88FA:
//------------------------------
SnakeDisplayRoutine:
    lda SnakeArrayControl - 1,x 
    and #$80
    beq !ExitSnakeDisplay+      // L_BRS_899F_899A
    jmp SetCharAndColourAtXY    // L_jmp_8172_8570
//------------------------------
// L_BRS_899F_899A:
// L_BRS_899F_89A4:
//------------------------------
!ExitSnakeDisplay:
    rts 
//------------------------------
// L_jsr_89A0_83B8:
//------------------------------
MasterTimerReset:
    lda MasterTimer 
    cmp #$FF
    bne !ExitSnakeDisplay-          // L_BRS_899F_89A4
    lda #$80
    sta MasterTimer 
    rts 
//------------------------------
// L_jsr_89AB_84E2:
//------------------------------
IsPODisShipsSpot:
    ldx #$07
//------------------------------
// L_BRS_89AD_89B3:
//------------------------------
!PODTestLoop:
    // cmp $871F,x 
    cmp PODCharacters,x
    beq !PODDetected+               // L_BRS_89B8_89B0
    dex 
    bne !PODTestLoop-               // L_BRS_89AD_89B3
    jmp IsFriendlyFireInShipSpot        // L_jmp_8BEC_89B5
//------------------------------
// L_BRS_89B8_89B0:
//------------------------------
!PODDetected:
    lda ShipRow
    sta ScreenColumn 
    lda ShipRow 
    sta ScreenRow 
    rts 
//------------------------------
// L_jsr_89C1_88D2:
//------------------------------
InsertingNewSnake:
    lda NumberofSnakeChars 
    bne !InsertSnake+                   // L_BRS_89E6_89C3
    dec SnakeTimer 
    beq !IsItASnakeLevel+               // L_BRS_8A0C_89C7
    rts 
//------------------------------
// L_BRS_89CA_8A0E:
//------------------------------
!DefiningSnakeHead:
    lda #$20
    sta SnakeTimer 
    lda LevelSnakeLength 
    sta NumberofSnakeChars 
    inc NoOfActiveSnakes 
    ldx NoOfActiveSnakes 
    lda #$0A
    sta SnakeArrayCol - 1,x 
    lda #$02
    sta SnakeArrayRow - 1,x 
    lda #$41
    sta SnakeArrayControl - 1,x 
    rts 
//------------------------------
// L_BRS_89E6_89C3:
//------------------------------
!InsertSnake:
    inc NoOfActiveSnakes 
    ldx NoOfActiveSnakes 
    lda #$00
    sta SnakeArrayControl - 1,x 
    lda #$02
    sta SnakeArrayRow - 1,x 
    lda #$0A
    sta SnakeArrayCol - 1,x 
    dec NumberofSnakeChars 
    lda NumberofSnakeChars 
    cmp #$01
    beq !DefiningSnakeTail+       // L_BRS_8A02_89FF
    rts 
//------------------------------
// L_BRS_8A02_89FF:
//------------------------------
!DefiningSnakeTail:
    dec NumberofSnakeChars 
    dec NoOfSnakesForLevel 
    lda #$80
    sta SnakeArrayControl - 1,x 
    rts 
//------------------------------
// L_BRS_8A0C_89C7:
//------------------------------
!IsItASnakeLevel:
    lda NoOfSnakesForLevel 
    bne !DefiningSnakeHead-          // L_BRS_89CA_8A0E
    rts 
//------------------------------
// L_jmp_8A11_87D5:
//------------------------------
CheckForSnake:
    cmp #SNAKE_ANI_START
    beq !HitSnakeBody+                  // L_BRS_8A28_8A13
    cmp #SNAKE_ANI_START + 1
    beq !HitSnakeUpDateScore+           // L_BRS_8A21_8A17
    cmp #SNAKE_ANI_START + 2
    beq !HitSnakeUpDateScore+           // L_BRS_8A21_8A1B
    nop 
    nop 
    nop 
    rts 
//------------------------------
//L_BRS_8A21_8A17:
//L_BRS_8A21_8A1B:
//------------------------------
!HitSnakeUpDateScore:
    ldx #$04
    ldy #$03
    jsr UpdateScore             // L_jsr_8870_8A25
//------------------------------
// L_BRS_8A28_8A13:
//------------------------------
!HitSnakeBody:
    ldx #$04
    ldy #$01
    jsr ResetPODTimers          // L_jsr_8A99_8A2C
    lda #$FF
    sta BulletRow 
    pla 
    pla 
    ldx NoOfActiveSnakes 
//------------------------------
// L_BRS_8A37_8A3F:
//------------------------------
!WhereWasSnakeHit:
    lda SnakeArrayCol - 1,x 
    cmp ScreenColumn 
    beq !SnakeHitHere+                  // L_BRS_8A42_8A3C
//------------------------------
// L_BRS_8A3E_8A47:
//------------------------------
!NotTheRightRowForSnakeHit:
    dex 
    bne !WhereWasSnakeHit-              // L_BRS_8A37_8A3F
    rts 
//------------------------------
// L_BRS_8A42_8A3C:
//------------------------------
!SnakeHitHere:
    lda SnakeArrayRow - 1,x 
    cmp ScreenRow 
    bne !NotTheRightRowForSnakeHit-       // L_BRS_8A3E_8A47
    lda SnakeArrayControl - 1,x 
    and #$C0
    bne !ItsAControlChar+               //L_BRS_8A7A_8A4E
    jsr JustSnakeBody                   // L_jsr_8AA4_8A50
//------------------------------
// L_jmp_8A53_8A6A:
// L_BRS_8A53_8A7C:
// L_jmp_8A53_8A8A:
// L_jmp_8A53_8A96:
//------------------------------
!MoveSnakeLooper:
    lda SnakeArrayRow,x 
    sta SnakeArrayRow - 1,x 
    lda SnakeArrayCol,x 
    sta SnakeArrayCol - 1,x 
    lda SnakeArrayControl,x 
    sta SnakeArrayControl - 1,x 
    cpx NoOfActiveSnakes 
    beq !YupLastSnake+              // L_BRS_8A6D_8A67
    inx 
    jmp !MoveSnakeLooper-           // L_jmp_8A53_8A6A
//------------------------------
// L_BRS_8A6D_8A67:
//------------------------------
!YupLastSnake:
    lda #PODColour
    sta ScreenCharColour 
    lda #PODCharacter
    sta ScreenCharacter 
    dec NoOfActiveSnakes 
    jmp SetCharAndColourAtXY    // L_jmp_8172_8570
//------------------------------
// L_BRS_8A7A_8A4E:
//------------------------------
!ItsAControlChar:
    cmp #$C0
    beq !MoveSnakeLooper-               // L_BRS_8A53_8A7C
    cmp #$40
    beq !HeadOfSnake+                   // L_BRS_8A8D_8A80
    lda SnakeArrayControl - 2,x 
    ora #$80
    sta SnakeArrayControl - 2,x 
    jmp !MoveSnakeLooper-               // L_jmp_8A53_8A8A
//------------------------------
// L_BRS_8A8D_8A80:
//------------------------------
!HeadOfSnake:
    lda SnakeArrayControl,x 
    ora SnakeArrayControl - 1,x
    sta SnakeArrayControl,x 
    jmp !MoveSnakeLooper-               // L_jmp_8A53_8A96
//------------------------------
// L_jsr_8A99_8A2C:
//------------------------------
ResetPODTimers:
    lda #$F0
    sta PODSfxTimer 
    lda #$03
    sta PODSfxLoopCounter 
    jmp UpdateScore                 // L_jmp_8870_8AA1
//------------------------------
// L_jsr_8AA4_8A50:
//------------------------------
JustSnakeBody:
    stx CurrentSnakeIndex 
//------------------------------
// L_BRS_8AA6_8AAC:
//------------------------------
!SnakeBodyLooper:
    dex 
    lda SnakeArrayControl - 1,x 
    and #$40
    beq !SnakeBodyLooper-               // L_BRS_8AA6_8AAC
    lda SnakeArrayControl - 1,x 
    nop 
    nop 
    ldx CurrentSnakeIndex 
    jsr !ChangeControlState+            // L_jsr_8AC1_8AB5
    lda SnakeArrayControl - 2,x 
    ora #$80
    sta SnakeArrayControl - 2,x 
    rts 
//------------------------------
// L_jsr_8AC1_8AB5:
//------------------------------
!ChangeControlState:
    ora SnakeArrayControl,x
    sta SnakeArrayControl,x 
    rts 
//------------------------------
// L_jsr_8AC8_83BB:
//------------------------------
LevelCompletedControl:
    lda NoOfSnakesForLevel 
    beq !NoMoreSnakesToBeAdded+      // L_BRS_8ACD_8ACA
//------------------------------
// L_BRS_8ACC_8ACF:
//------------------------------
!Exit:
    rts 
//------------------------------
//L_BRS_8ACD_8ACA:
//------------------------------
!NoMoreSnakesToBeAdded:
    lda NoOfActiveSnakes 
    bne !Exit-                  // L_BRS_8ACC_8ACF
    jmp DisplayBattleStations   // L_jmp_8C2D_80F4
    jsr GetCharacterFromScreenLocation          // L_jsr_818B_8020
    cmp #$07
    beq ResetTheStack           // L_BRS_8ADE_8AD9
    jmp SetCharAndColourAtXY    // L_jmp_8172_8570
//------------------------------
// L_jmp_8ADE_8028:
// L_jmp_8ADE_877E:
// L_jmp_8ADE_87B8:
// L_BRS_8ADE_8AD9:
// L_BRS_8ADE_8AEB:
// L_jmp_8ADE_8AF5:
// L_jmp_8ADE_8BF8:
//------------------------------
ResetTheStack:
    ldx #$F6
    txs 
    nop 
    nop 
    nop 
    jmp ResettingScreenCharacterInPos   // L_jmp_8D78_8AE4
    rts 
//------------------------------
    nop 
//------------------------------
// L_jsr_8AE9_893E:
//------------------------------
HaveWeEatenPlayerShip:
    cmp #SHIPCharacter
    beq ResetTheStack                   // L_BRS_8ADE_8AEB
    lda SnakeArrayCol - 1,x 
//------------------------------
// L_BRS_8AF0_8AF3:
//------------------------------
!Exit:
    rts 
//------------------------------
    cmp #$20 // <---- Is this a Space
    beq !Exit-                          // L_BRS_8AF0_8AF3
    jmp ResetTheStack                   // L_jmp_8ADE_8AF5
//------------------------------
// L_jmp_8AF8_8D8B:
//------------------------------
ShipExplosion:
    lda #$0F
    sta CurrentSIDVolumnLevel 
    lda ShipColumn 
    ldx #$08
//------------------------------
// L_BRS_8B00_8B04:
//------------------------------
!Looper:
    sta ShipColExplosionArr,x 
    dex 
    bne !Looper-            // L_BRS_8B00_8B04
    lda ShipRow 
    ldx #$08
//------------------------------
//L_BRS_8B0A_8B0E:
//------------------------------
!Looper:
    sta ShipRowExplosionArr,x 
    dex
    bne !Looper-            // L_BRS_8B0A_8B0E
    lda #$00
    sta SID_VCREG1 
    sta SID_VCREG2 
    sta SID_VCREG3 
    lda #$03
    sta SID_FREHI1 
    lda #EXPLOSION_ANI_START
    sta ExplosionCharacter 
//------------------------------
// L_jmp_8B24_8BB5:
//------------------------------
ExplosionAnimationCycle:
    lda #$00
    sta SID_VCREG1 
    lda #$81
    sta SID_VCREG1 
    lda CurrentSIDVolumnLevel 
    sta SID_SIGVOL 
    ldx #$08
    lda #ExplosionColourStart
    sta ScreenCharColour 
    lda #GRIDCharacter
    sta ScreenCharacter 
//------------------------------
// L_BRS_8B3D_8B56:
//------------------------------
!ExpArrTestLoop:
    lda ShipColExplosionArr,x 
    sta ScreenColumn 
    lda ShipRowExplosionArr,x 
    sta ScreenRow 
    stx CurrentSnakeIndex 
    jsr GetCharacterFromScreenLocation          // L_jsr_818B_8020
    cmp ExplosionCharacter 
    bne !NotExplosionChar+              // L_BRS_8B53_8B4E
    jsr SetCharAndColourAtXY    // L_jmp_8172_8570
//------------------------------
// L_BRS_8B53_8B4E:
//------------------------------
!NotExplosionChar:
    ldx CurrentSnakeIndex 
    dex 
    bne !ExpArrTestLoop-            // L_BRS_8B3D_8B56
    lda #$14
//------------------------------
L_BRS_8B5A_8B5E:
//------------------------------
    jmp L_jmp_8B60_8B5A
    dex                     // OSK, Why?
    bne L_BRS_8B5A_8B5E     // OSK, Why?
//------------------------------
L_jmp_8B60_8B5A:
//------------------------------
    inc ExplosionCharacter 
    lda ExplosionCharacter 
    cmp #EXPLOSION_ANI_END
    bne !NotEndOfAnimation+         // L_BRS_8B6C_8B66
    lda #EXPLOSION_ANI_START
    sta ExplosionCharacter 
//------------------------------
// L_BRS_8B6C_8B66:
//------------------------------
!NotEndOfAnimation:
    ldx #$08
//------------------------------
// L_BRS_8B6E_8BD5:
//------------------------------
!ExplosionArrayLoop:
    lda ExplosionDirectionCol - 1,x 
    cmp #$80
    beq !ExplosionGoingLeft+        // L_BRS_8B7F_8B73
    cmp #$00
    beq !ExplosionGoingRight+       // L_BRS_8B7C_8B77
    inc ShipColExplosionArr,x 
//------------------------------
// L_BRS_8B7C_8B77:
//------------------------------
!ExplosionGoingRight:
    inc ShipColExplosionArr,x 
//------------------------------
// L_BRS_8B7F_8B73:
//------------------------------
!ExplosionGoingLeft:
    jsr CalculatingExplosionCol     // L_jsr_8040_8B7F
    lda ExplosionDirectionRow - 1,x 
    beq !ExplosionRowStatic+        // L_BRS_8B8E_8B85
    cmp #$80
    beq !ExplosionGoingUp+          // L_BRS_8B91_8B89
    inc ShipRowExplosionArr,x 
//------------------------------
// L_BRS_8B8E_8B85:
//------------------------------
!ExplosionRowStatic:
    inc ShipRowExplosionArr,x 
//------------------------------
// L_BRS_8B91_8B89:
//------------------------------
!ExplosionGoingUp:
    jsr CalculatingExplosionRow     // L_jsr_8056_8B91
    lda ShipColExplosionArr,x 
    sta ScreenColumn 
    lda ShipRowExplosionArr,x 
    sta ScreenRow 
    lda #ExplosionColour
    sta ScreenCharColour 
    lda ExplosionCharacter 
    sta ScreenCharacter 
    jsr !GetCharacterUnderExplosion+    // L_jsr_8BBB_8BA6
    bne !NotAGridCharacter+         // L_BRS_8BAE_8BA9
    jsr SetCharAndColourAtXY    // L_jmp_8172_8570
//------------------------------
// L_BRS_8BAE_8BA9:
//------------------------------
!NotAGridCharacter:
    jmp EndOfExplosionLoopCheck    // L_jmp_8BD2_8BAE
//------------------------------
// L_jmp_8BB1_8BE9:
//------------------------------
ExplosionSoundControl:
    dec CurrentSIDVolumnLevel 
    bmi !ExplosionFinished+         // L_BRS_8BB8_8BB3
    jmp ExplosionAnimationCycle     // L_jmp_8B24_8BB5
//------------------------------
// L_BRS_8BB8_8BB3:
//------------------------------
!ExplosionFinished:
    jmp UpdateNumberOfLives         // L_jmp_8C17_8BB8
//------------------------------
// L_jsr_8BBB_8BA6:
//------------------------------
!GetCharacterUnderExplosion:
    stx CurrentSnakeIndex 
    jmp GetCharacterFromScreenLocation          // L_jsr_818B_8020
    nop 

// *=$8BC1
ExplosionDirectionCol:
    .byte $00,$01,$01,$01,$00,$80,$80,$80
ExplosionDirectionRow:
    .byte $80,$80,$00,$01,$01,$01,$00,$80

    nop 
//------------------------------
// L_jmp_8BD2_8BAE:
//------------------------------
EndOfExplosionLoopCheck:
    ldx CurrentSnakeIndex 
    dex 
    bne !ExplosionArrayLoop-    // L_BRS_8B6E_8BD5
    ldx #$10
//------------------------------
// L_BRS_8BD9_8BDD:
//------------------------------
!DelayLoop:
    jsr TwoStage256Delay    // L_jsr_8386_8BD9
    dex 
    bne !DelayLoop-         // L_BRS_8BD9_8BDD
    lda #$00
    sta SID_VCREG1 
    lda #$81
    sta SID_VCREG1 
    jmp ExplosionSoundControl   // L_jmp_8BB1_8BE9
//------------------------------
// L_jmp_8BEC_89B5:
//------------------------------
IsFriendlyFireInShipSpot:
    cmp #SHIPLaser1Character
    beq !ShipOkToMove+             // L_BRS_8BFB_8BEE
    cmp #SHIPLaser2Character
    beq !ShipOkToMove+             // L_BRS_8BFB_8BF2
    cmp #GRIDCharacter
    beq !ShipOkToMove+             // L_BRS_8BFB_8BF6

    // OSK Finished Here
    jmp ResetTheStack               // L_jmp_8ADE_8BF8
//------------------------------
// L_BRS_8BFB_8BEE:
// L_BRS_8BFB_8BF2:
// L_BRS_8BFB_8BF6:
//------------------------------
!ShipOkToMove:
    rts 
//------------------------------
// L_jsr_8BFC_8C17:
// L_jsr_8BFC_8C30:
//------------------------------
ClearGameScreenArea:
    lda #<PODDecayStartLocation
    sta $07 
    lda #>PODDecayStartLocation
    sta $08 
    ldy #$00
//------------------------------
//L_BRS_8C06_8C14:
//------------------------------
!ClearNextBankLoop:
    lda #SPACECharacter
//------------------------------
// L_BRS_8C08_8C0C:
//------------------------------
!BlackScreenAreaLoop:
    sta ($07),y 
    inc $07 
    bne !BlackScreenAreaLoop-             // L_BRS_8C08_8C0C
    inc $08 
    lda $08 
    cmp #>SCREEN_RAM_END
    bne !ClearNextBankLoop-             // L_BRS_8C06_8C14
    rts 
//------------------------------
// L_jmp_8C17_8BB8:
//------------------------------
UpdateNumberOfLives:
    jsr ClearGameScreenArea     // L_jsr_8BFC_8C17
    nop 
    nop 
    nop 
    dec NoOfLives 
    lda NoOfLives 
    cmp #$30
    beq !NoMoreLives+           // L_BRS_8C2A_8C25
    jmp PrepareBattleStations   // L_jmp_8D5E_8C27
//------------------------------
// L_BRS_8C2A_8C25:
//------------------------------
!NoMoreLives:
    jmp HiScoreTest             // L_jmp_8060_8C2A
//------------------------------
// L_jmp_8C2D_80F4:
// L_jmp_8C2D_8AD1:
// L_jmp_8C2D_8D63:
//------------------------------
DisplayBattleStations:
    ldx #$F6
    txs 
    jsr ClearGameScreenArea     // L_jsr_8BFC_8C30
    ldx #$12
//------------------------------
// L_BRS_8C35_8C4C:
//------------------------------
!CharacterLoop:
    lda BattleStationsText-1,x 
    sta BattleStationScreenLoc,x 
    lda #BattleStationColour
    sta BattleStationColourLoc,x 
    lda EnteringGridAreaText,x 
    sta EnteringGridAreaScreenLoc,x 
    lda #EnteringGridAreaColour
    sta EnteringGridAreaColourLoc,x 
    dex 
    bne !CharacterLoop-         // L_BRS_8C35_8C4C
    jmp SettingUpTheGameForThisLevel    // L_jmp_8C75_8C4E

//*=$8C51
BattleStationsText:
    .byte $20,$29,$28,$3A,$3A,$3E,$27,$20,$20,$2F,$3A,$28,$3A,$24,$30,$26,$2F
EnteringGridAreaText:    
    .byte $20,$27,$26,$3A,$27,$22,$20,$21,$22,$24,$25,$20,$28,$22,$27,$28,$20
    .byte $30,$30
//------------------------------
// L_jmp_8C75_8C4E:
//------------------------------
SettingUpTheGameForThisLevel:
    inc NoOfLives 
    lda NoOfLives 
    cmp #$3A
    bne !NotHitMaxLives+        // L_BRS_8C82_8C7D
    dec NoOfLives 
//------------------------------
// L_BRS_8C82_8C7D:
//------------------------------
!NotHitMaxLives:
    inc CurrentLevelNumber 
    lda CurrentLevelNumber 
    cmp #MAX_NUMBER_OF_LEVELS
    bne !NotHitMaxLevels+           // L_BRS_8C8C_8C88
    dec CurrentLevelNumber 
//------------------------------
// L_BRS_8C8C_8C88:
//------------------------------
!NotHitMaxLevels:
    ldx CurrentLevelNumber 
    lda NumberOfSnakes-1,x
    sta NoOfSnakesForLevel 
    lda SnakeLength-1,x 
    sta LevelSnakeLength 
    lda DelayForLaserFire-1,x 
    sta LevelLaserFiringReset 
//------------------------------
L_BRS_8C9D_8CB0:
//------------------------------
    inc EnteringGridAreaDigit1
    lda EnteringGridAreaDigit1 
    cmp #$3A
    bne L_BRS_8CAF_8CA5
    lda #$30
    sta EnteringGridAreaDigit1 
    inc EnteringGridAreaDigit2
//------------------------------
L_BRS_8CAF_8CA5:
//------------------------------
    dex 
    bne L_BRS_8C9D_8CB0
    jmp SetSIDVolumeMAX              // L_jmp_8D70_8CB2

// *=$8CB5
NumberOfSnakes:
    .byte $01,$02,$02,$03,$03,$03,$04,$04,$04,$04,$05,$05,$10,$06,$06,$06
    .byte $06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$07,$07,$07,$07,$07,$07

// *=$8CD5
SnakeLength:
    .byte $06,$06,$06,$07,$07,$08,$08,$09,$0C,$0C,$0A,$0A,$03,$0F,$10,$10
    .byte $11,$12,$13,$14,$14,$14,$15,$15,$16,$16,$16,$17,$03,$18,$18,$19
    
// *=$8CF5
DelayForLaserFire:
    .byte $10,$10,$10,$0F,$0E,$0D,$0C,$0B,$0A,$09,$09,$09,$09,$09,$09,$09
    .byte $08,$08,$08,$08,$07,$07,$07,$07,$07,$07,$07,$07,$07,$06,$06,$05
    
    nop
//------------------------------
L_jmp_8D16_8D75:
//------------------------------
    // Level Sound Effects
    lda #$30        // 30 Cycles
    sta $36 
//------------------------------
// L_BRS_8D1A_8D4D:
//------------------------------
!SoundLoop:
    lda $36 
    sta EnteringGridAreaColour1       // Colourise Level Number
    sta EnteringGridAreaColour2       // Colourise Level Number
    ldx $36         // Load X with Cycle Counter
//------------------------------
// L_BRS_8D24_8D49:
//------------------------------
!SoundFreqLoop:
    jsr L_jsr_8D52_8D24   // Reset Delay Counter
    jsr L_jsr_8D66_8D27   // Work Out New Frequency 
    nop 
    sta SID_FREHI2       // Store New Frequency Voice 2
    nop 
    sta SID_FREHI3       // Store New Frequency Voice 3
    lda #$00        // Resets The Voices       
    sta SID_VCREG1       // Voice 1
    sta SID_VCREG2       // Voice 2
    sta SID_VCREG3       // Voice 3

    lda #$25        // Set New Wave Form, Triangle, No Osscil
    sta SID_VCREG1       // Voice 1
    sta SID_VCREG2       // Voice 2
    sta SID_VCREG3       // Voice 3
    dex             // Reduce Sound Cycle By 1
    bne !SoundFreqLoop-     // L_BRS_8D24_8D49
    dec $36 
    bne !SoundLoop-         // L_BRS_8D1A_8D4D
    jmp GameActivation      // L_jmp_8300_8D4F
//------------------------------
L_jsr_8D52_8D24:
//------------------------------
    lda #$20                // New Delay Counter
    jmp TwoStageDelay       // L_jmp_8388_8D54     // Perform Delay
//------------------------------
L_jmp_8D57_881B:
//------------------------------
// Confirm this is redundant code, as it does bugger all :|
    lda CurrentLevelNumber 
    sta CurrentLevelNumber 
    jmp DisplayByJeffMinter     // L_jmp_8D8E_8D5B
//------------------------------
// L_jmp_8D5E_8C27
//------------------------------
PrepareBattleStations:
    dec NoOfLives 
    dec CurrentLevelNumber 
    jmp DisplayBattleStations   // L_jmp_8C2D_80F4
//------------------------------
L_jsr_8D66_8D27:
//------------------------------
    stx CurrentSnakeIndex         // Get Sound Loop Counter
    lda #$40        // Get Number Of Cycles
    sbc CurrentSnakeIndex         // Subtract Sound Loop Counter
    sta SID_FREHI1       // Store New Frequency In Voice 1
    rts 
//------------------------------
// L_jmp_8D70_8CB2:
//------------------------------
SetSIDVolumeMAX:
    lda #$0F        // Set Volumne To MAX
    sta SID_SIGVOL       // Set Volumne
    jmp L_jmp_8D16_8D75
//------------------------------
// L_jmp_8D78_8AE4:
//------------------------------
ResettingScreenCharacterInPos:
    lda #GRIDCharacter
    sta ScreenCharacter 
    lda #GRIDColour
    sta ScreenCharColour 
    lda ShipColumn 
    sta ScreenColumn 
    lda ShipRow 
    sta ScreenRow 
    jsr SetCharAndColourAtXY    // L_jmp_8172_8570
    jmp ShipExplosion           // L_jmp_8AF8_8D8B
//------------------------------
//L_jmp_8D8E_801A:
//L_jmp_8D8E_806D:
//L_jmp_8D8E_807D:
//L_jmp_8D8E_8D5B:
//------------------------------
// By Jeff Minter and Enter Level 00 Routine
DisplayByJeffMinter:
    lda #$01
    sta CurrentLevelNumber 
    ldx #$0E
//------------------------------
//L_BRS_8D94_8DAB:
//------------------------------
!CharacterLooper:
    lda ByJeffMinterTXT - 1,x 
    sta ByJeffMinterScreenLoc,x 
    lda #ByJeffMinterColour
    sta ByJeffMinterColourLoc,x 
    lda EnterLevelTXT - 1,x 
    sta EnterLevelScreenLoc,x 
    lda #EnterLevelColour
    sta EnterLevelColourLoc,x 
    dex 
    bne !CharacterLooper-       // L_BRS_8D94_8DAB
    jmp DisplayCopyRight        //L_jmp_80D2_8DAD
//------------------------------
// L_BRS_8DB0_8DBC:
// L_jmp_8DB0_8DC3:
//------------------------------
AwaitingFireButton:
    lda CIAPRB + $10 
    cmp #($FF - joyFIRE)         // Fire Button
    bne !TestForUp+             // L_BRS_8DBA_8DB5 
    jmp FireButtonPressed       // L_jmp_8DC6_8DB7
//------------------------------
//L_BRS_8DBA_8DB5:
//------------------------------
!TestForUp:
    cmp #($FF - joyUP)         // Joystick Up
    bne AwaitingFireButton
    inc CurrentLevelNumber      // Increase LevelNumber
//------------------------------
// L_jmp_8DC0_80E2:
//------------------------------
LevelSelection:
    jsr DisplayLevelNumber      // L_jsr_80A0_8DC0 
    jmp AwaitingFireButton      // L_jmp_8DB0_8DC3 
//------------------------------
// L_jmp_8DC6_8DB7:
//------------------------------
FireButtonPressed:
    dec CurrentLevelNumber 
    jmp BeginGame               // L_jmp_80E5_8DC8

    .byte $B0,$8D
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop

// *=$8DE1
ByJeffMinterTXT:
    .byte $29,$1B,$20,$2C,$27,$2A,$2A,$20,$2D,$24,$26,$3A,$27,$22,$20,$EA
EnterLevelTXT:
    .byte $27,$26,$3A,$27,$22,$20,$3E,$27,$3B,$27,$3E,$20,$30,$30,$20

    // By John Dale
// ByJeffMinterTXT:
//     .byte $29,$1B,$20,$2C,$30,$2B,$26,$20,$25,$28,$3e,$27,$20,$20,$20,$EA
// EnterLevelTXT:
//     .byte $27,$26,$3A,$27,$22,$20,$3E,$27,$3B,$27,$3E,$20,$30,$30,$20

//$8E00 -> $9000 CharSet

*=$8E00 "Character Set"
//.import binary "GridCS.bin"
#import "GridCS.asm"
