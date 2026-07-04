!--------------------------------------------------------------------------------------------------
!
!--------------------------------------------------------------------------------------------------
!     FILE reduced/reducedS16R154QSS7_0.f90
!>    @file reduced/reducedS16R154QSS7_0.f90 
!!    Module for calculating the analytical source terms in Cantera  
!!    @details 
!!    @authors
!!    @date    2021/07/10
!!    @since     
!!    @note      
!--------------------------------------------------------------------------------------------------

!--------------------------------------------------------------------------------------------------
!     MODULE mod_customkinetics
!>    @details 
!!    @authors
!!    @date    2021/07/10
!--------------------------------------------------------------------------------------------------
module mod_customkinetics
  implicit none

  integer, parameter :: pr = selected_real_kind(15,307)

  ! Ideal gas constant
  real(pr), parameter :: Rcst = 8.3144621_pr
  
  ! Use semi-implicit formulation for select species
  logical, parameter :: semiImplicit = .False.
  
  ! Number of elements in the chemical system 
  integer, parameter :: ne = 3
  
  ! Number of non-qss and qss species and reactions
  integer, parameter :: nspec = 16
  integer, parameter :: nqss = 7
  integer, parameter :: nreac = 154
  integer, parameter :: nreac_reverse = 125
  
  ! Actual expression of each reaction
  character(len=65), dimension(nreac + nreac_reverse) :: reacexp
  
  ! Number of thirdbodies
  integer, parameter :: nTB = 8
  integer, parameter :: nFO = 13
  integer, parameter :: nTB_reverse = 7
  integer, parameter :: nFO_reverse = 13
  
  ! Index of elements
  integer, parameter :: eH = 1
  integer, parameter :: eO = 2
  integer, parameter :: eC = 3

  ! Index of species
  integer, parameter :: sN2 = 1
  integer, parameter :: sH2 = 2
  integer, parameter :: sH = 3
  integer, parameter :: sO2 = 4
  integer, parameter :: sO = 5
  integer, parameter :: sH2O = 6
  integer, parameter :: sOH = 7
  integer, parameter :: sHO2 = 8
  integer, parameter :: sCO = 9
  integer, parameter :: sCO2 = 10
  integer, parameter :: sCH4 = 11
  integer, parameter :: sCH3 = 12
  integer, parameter :: sCH2O = 13
  integer, parameter :: sC2H6 = 14
  integer, parameter :: sC2H4 = 15
  integer, parameter :: sC2H2 = 16

  integer, parameter :: sqssH2O2 = 1
  integer, parameter :: sqssCH3O = 2
  integer, parameter :: sqssHCO = 3
  integer, parameter :: sqssC2H5 = 4
  integer, parameter :: sqssC2H3 = 5
  integer, parameter :: sqssHCCO = 6
  integer, parameter :: sqssCH2GL1G = 7

  ! Index of reactions
  integer, parameter :: r1f = 1
  integer, parameter :: r2f = 2
  integer, parameter :: r3f = 3
  integer, parameter :: r4f = 4
  integer, parameter :: r5f = 5
  integer, parameter :: r6f = 6
  integer, parameter :: r7f = 7
  integer, parameter :: r8f = 8
  integer, parameter :: r9f = 9
  integer, parameter :: r10f = 10
  integer, parameter :: r11f = 11
  integer, parameter :: r12f = 12
  integer, parameter :: r13f = 13
  integer, parameter :: r14f = 14
  integer, parameter :: r15f = 15
  integer, parameter :: r16f = 16
  integer, parameter :: r17f = 17
  integer, parameter :: r18f = 18
  integer, parameter :: r19f = 19
  integer, parameter :: r20f = 20
  integer, parameter :: r21f = 21
  integer, parameter :: r22f = 22
  integer, parameter :: r23f = 23
  integer, parameter :: r24f = 24
  integer, parameter :: r25f = 25
  integer, parameter :: r26f = 26
  integer, parameter :: r27f = 27
  integer, parameter :: r28f = 28
  integer, parameter :: r29f = 29
  integer, parameter :: r30f = 30
  integer, parameter :: r31f = 31
  integer, parameter :: r32f = 32
  integer, parameter :: r33f = 33
  integer, parameter :: r34f = 34
  integer, parameter :: r35f = 35
  integer, parameter :: r36f = 36
  integer, parameter :: r37f = 37
  integer, parameter :: r38f = 38
  integer, parameter :: r39f = 39
  integer, parameter :: r40f = 40
  integer, parameter :: r41f = 41
  integer, parameter :: r42f = 42
  integer, parameter :: r43f = 43
  integer, parameter :: r44f = 44
  integer, parameter :: r45f = 45
  integer, parameter :: r46f = 46
  integer, parameter :: r47f = 47
  integer, parameter :: r48f = 48
  integer, parameter :: r49f = 49
  integer, parameter :: r50f = 50
  integer, parameter :: r51f = 51
  integer, parameter :: r52f = 52
  integer, parameter :: r53f = 53
  integer, parameter :: r54f = 54
  integer, parameter :: r55f = 55
  integer, parameter :: r56f = 56
  integer, parameter :: r57f = 57
  integer, parameter :: r58f = 58
  integer, parameter :: r59f = 59
  integer, parameter :: r60f = 60
  integer, parameter :: r61f = 61
  integer, parameter :: r62f = 62
  integer, parameter :: r63f = 63
  integer, parameter :: r64f = 64
  integer, parameter :: r65f = 65
  integer, parameter :: r66f = 66
  integer, parameter :: r67f = 67
  integer, parameter :: r68f = 68
  integer, parameter :: r69f = 69
  integer, parameter :: r70f = 70
  integer, parameter :: r71f = 71
  integer, parameter :: r72f = 72
  integer, parameter :: r73f = 73
  integer, parameter :: r74f = 74
  integer, parameter :: r75f = 75
  integer, parameter :: r76f = 76
  integer, parameter :: r77f = 77
  integer, parameter :: r78f = 78
  integer, parameter :: r79f = 79
  integer, parameter :: r80f = 80
  integer, parameter :: r81f = 81
  integer, parameter :: r82f = 82
  integer, parameter :: r83f = 83
  integer, parameter :: r84f = 84
  integer, parameter :: r85f = 85
  integer, parameter :: r86f = 86
  integer, parameter :: r87f = 87
  integer, parameter :: r88f = 88
  integer, parameter :: r89f = 89
  integer, parameter :: r90f = 90
  integer, parameter :: r91f = 91
  integer, parameter :: r92f = 92
  integer, parameter :: r93f = 93
  integer, parameter :: r94f = 94
  integer, parameter :: r95f = 95
  integer, parameter :: r96f = 96
  integer, parameter :: r97f = 97
  integer, parameter :: r98f = 98
  integer, parameter :: r99f = 99
  integer, parameter :: r100f = 100
  integer, parameter :: r101f = 101
  integer, parameter :: r102f = 102
  integer, parameter :: r103f = 103
  integer, parameter :: r104f = 104
  integer, parameter :: r105f = 105
  integer, parameter :: r106f = 106
  integer, parameter :: r107f = 107
  integer, parameter :: r108f = 108
  integer, parameter :: r109f = 109
  integer, parameter :: r110f = 110
  integer, parameter :: r111f = 111
  integer, parameter :: r112f = 112
  integer, parameter :: r113f = 113
  integer, parameter :: r114f = 114
  integer, parameter :: r115f = 115
  integer, parameter :: r116f = 116
  integer, parameter :: r117f = 117
  integer, parameter :: r118f = 118
  integer, parameter :: r119f = 119
  integer, parameter :: r120f = 120
  integer, parameter :: r121f = 121
  integer, parameter :: r122f = 122
  integer, parameter :: r123f = 123
  integer, parameter :: r124f = 124
  integer, parameter :: r125f = 125
  integer, parameter :: r126f = 126
  integer, parameter :: r127f = 127
  integer, parameter :: r128f = 128
  integer, parameter :: r129f = 129
  integer, parameter :: r130f = 130
  integer, parameter :: r131f = 131
  integer, parameter :: r132f = 132
  integer, parameter :: r133f = 133
  integer, parameter :: r134f = 134
  integer, parameter :: r135f = 135
  integer, parameter :: r136f = 136
  integer, parameter :: r137f = 137
  integer, parameter :: r138f = 138
  integer, parameter :: r139f = 139
  integer, parameter :: r140f = 140
  integer, parameter :: r141f = 141
  integer, parameter :: r142f = 142
  integer, parameter :: r143f = 143
  integer, parameter :: r144f = 144
  integer, parameter :: r145f = 145
  integer, parameter :: r146f = 146
  integer, parameter :: r147f = 147
  integer, parameter :: r148f = 148
  integer, parameter :: r149f = 149
  integer, parameter :: r150f = 150
  integer, parameter :: r151f = 151
  integer, parameter :: r152f = 152
  integer, parameter :: r153f = 153
  integer, parameter :: r154f = 154
  integer, parameter :: r1b = 155
  integer, parameter :: r2b = 156
  integer, parameter :: r3b = 157
  integer, parameter :: r4b = 158
  integer, parameter :: r5b = 159
  integer, parameter :: r6b = 160
  integer, parameter :: r7b = 161
  integer, parameter :: r8b = 162
  integer, parameter :: r9b = 163
  integer, parameter :: r10b = 164
  integer, parameter :: r11b = 165
  integer, parameter :: r12b = 166
  integer, parameter :: r13b = 167
  integer, parameter :: r14b = 168
  integer, parameter :: r15b = 169
  integer, parameter :: r16b = 170
  integer, parameter :: r17b = 171
  integer, parameter :: r18b = 172
  integer, parameter :: r19b = 173
  integer, parameter :: r20b = 174
  integer, parameter :: r21b = 175
  integer, parameter :: r22b = 176
  integer, parameter :: r23b = 177
  integer, parameter :: r24b = 178
  integer, parameter :: r25b = 179
  integer, parameter :: r26b = 180
  integer, parameter :: r27b = 181
  integer, parameter :: r28b = 182
  integer, parameter :: r29b = 183
  integer, parameter :: r30b = 184
  integer, parameter :: r31b = 185
  integer, parameter :: r32b = 186
  integer, parameter :: r33b = 187
  integer, parameter :: r34b = 188
  integer, parameter :: r36b = 189
  integer, parameter :: r37b = 190
  integer, parameter :: r38b = 191
  integer, parameter :: r39b = 192
  integer, parameter :: r40b = 193
  integer, parameter :: r41b = 194
  integer, parameter :: r42b = 195
  integer, parameter :: r43b = 196
  integer, parameter :: r46b = 197
  integer, parameter :: r47b = 198
  integer, parameter :: r48b = 199
  integer, parameter :: r49b = 200
  integer, parameter :: r50b = 201
  integer, parameter :: r51b = 202
  integer, parameter :: r52b = 203
  integer, parameter :: r53b = 204
  integer, parameter :: r54b = 205
  integer, parameter :: r55b = 206
  integer, parameter :: r56b = 207
  integer, parameter :: r57b = 208
  integer, parameter :: r58b = 209
  integer, parameter :: r59b = 210
  integer, parameter :: r60b = 211
  integer, parameter :: r61b = 212
  integer, parameter :: r62b = 213
  integer, parameter :: r63b = 214
  integer, parameter :: r64b = 215
  integer, parameter :: r65b = 216
  integer, parameter :: r66b = 217
  integer, parameter :: r67b = 218
  integer, parameter :: r68b = 219
  integer, parameter :: r69b = 220
  integer, parameter :: r70b = 221
  integer, parameter :: r71b = 222
  integer, parameter :: r73b = 223
  integer, parameter :: r74b = 224
  integer, parameter :: r75b = 225
  integer, parameter :: r76b = 226
  integer, parameter :: r77b = 227
  integer, parameter :: r78b = 228
  integer, parameter :: r79b = 229
  integer, parameter :: r80b = 230
  integer, parameter :: r81b = 231
  integer, parameter :: r82b = 232
  integer, parameter :: r83b = 233
  integer, parameter :: r84b = 234
  integer, parameter :: r85b = 235
  integer, parameter :: r86b = 236
  integer, parameter :: r87b = 237
  integer, parameter :: r88b = 238
  integer, parameter :: r89b = 239
  integer, parameter :: r90b = 240
  integer, parameter :: r91b = 241
  integer, parameter :: r92b = 242
  integer, parameter :: r93b = 243
  integer, parameter :: r94b = 244
  integer, parameter :: r95b = 245
  integer, parameter :: r96b = 246
  integer, parameter :: r97b = 247
  integer, parameter :: r98b = 248
  integer, parameter :: r99b = 249
  integer, parameter :: r100b = 250
  integer, parameter :: r101b = 251
  integer, parameter :: r104b = 252
  integer, parameter :: r105b = 253
  integer, parameter :: r106b = 254
  integer, parameter :: r107b = 255
  integer, parameter :: r108b = 256
  integer, parameter :: r109b = 257
  integer, parameter :: r110b = 258
  integer, parameter :: r111b = 259
  integer, parameter :: r112b = 260
  integer, parameter :: r113b = 261
  integer, parameter :: r114b = 262
  integer, parameter :: r117b = 263
  integer, parameter :: r120b = 264
  integer, parameter :: r121b = 265
  integer, parameter :: r122b = 266
  integer, parameter :: r123b = 267
  integer, parameter :: r124b = 268
  integer, parameter :: r125b = 269
  integer, parameter :: r126b = 270
  integer, parameter :: r130b = 271
  integer, parameter :: r131b = 272
  integer, parameter :: r132b = 273
  integer, parameter :: r133b = 274
  integer, parameter :: r134b = 275
  integer, parameter :: r136b = 276
  integer, parameter :: r140b = 277
  integer, parameter :: r141b = 278
  integer, parameter :: r147b = 279
  
  ! Index of third body species
  integer, parameter :: mM1 = 1
  integer, parameter :: mM4 = 2
  integer, parameter :: mM6 = 3
  integer, parameter :: mM8 = 4
  integer, parameter :: mM65 = 5
  integer, parameter :: mM88 = 6
  integer, parameter :: mM126 = 7
  integer, parameter :: mM146 = 8
  
  integer, parameter :: mM9 = 9
  integer, parameter :: mM22 = 10
  integer, parameter :: mM23 = 11
  integer, parameter :: mM28 = 12
  integer, parameter :: mM42 = 13
  integer, parameter :: mM58 = 14
  integer, parameter :: mM59 = 15
  integer, parameter :: mM73 = 16
  integer, parameter :: mM74 = 17
  integer, parameter :: mM75 = 18
  integer, parameter :: mM82 = 19
  integer, parameter :: mM87 = 20
  integer, parameter :: mM97 = 21
  
  ! Index of third body reactions
  integer, parameter :: TBr1f = 1
  integer, parameter :: TBr4f = 2
  integer, parameter :: TBr6f = 3
  integer, parameter :: TBr8f = 4
  integer, parameter :: TBr65f = 5
  integer, parameter :: TBr88f = 6
  integer, parameter :: TBr126f = 7
  integer, parameter :: TBr146f = 8
  integer, parameter :: TBr1b = 9
  integer, parameter :: TBr4b = 10
  integer, parameter :: TBr6b = 11
  integer, parameter :: TBr8b = 12
  integer, parameter :: TBr65b = 13
  integer, parameter :: TBr88b = 14
  integer, parameter :: TBr126b = 15
  
  ! Index of fall off reactions
  integer, parameter :: FOr9f = 1
  integer, parameter :: FOr22f = 2
  integer, parameter :: FOr23f = 3
  integer, parameter :: FOr28f = 4
  integer, parameter :: FOr42f = 5
  integer, parameter :: FOr58f = 6
  integer, parameter :: FOr59f = 7
  integer, parameter :: FOr73f = 8
  integer, parameter :: FOr74f = 9
  integer, parameter :: FOr75f = 10
  integer, parameter :: FOr82f = 11
  integer, parameter :: FOr87f = 12
  integer, parameter :: FOr97f = 13
  integer, parameter :: FOr9b = 14
  integer, parameter :: FOr22b = 15
  integer, parameter :: FOr23b = 16
  integer, parameter :: FOr28b = 17
  integer, parameter :: FOr42b = 18
  integer, parameter :: FOr58b = 19
  integer, parameter :: FOr59b = 20
  integer, parameter :: FOr73b = 21
  integer, parameter :: FOr74b = 22
  integer, parameter :: FOr75b = 23
  integer, parameter :: FOr82b = 24
  integer, parameter :: FOr87b = 25
  integer, parameter :: FOr97b = 26
  
  ! Molar mass
  real(pr), parameter, dimension(nspec) :: W_sp =(/ &
       0.02801348_pr, & ! N2
       0.00201588_pr, & ! H2
       0.00100794_pr, & ! H
       0.0319988_pr, & ! O2
       0.0159994_pr, & ! O
       0.01801528_pr, & ! H2O
       0.01700734_pr, & ! OH
       0.03300674_pr, & ! HO2
       0.0280104_pr, & ! CO
       0.0440098_pr, & ! CO2
       0.01604276_pr, & ! CH4
       0.01503482_pr, & ! CH3
       0.03002628_pr, & ! CH2O
       0.03006964_pr, & ! C2H6
       0.02805376_pr, & ! C2H4
       0.02603788_pr & ! C2H2
      !0.03401468_pr, & ! H2O2
      !0.03103422_pr, & ! CH3O
      !0.02901834_pr, & ! HCO
      !0.0290617_pr, & ! C2H5
      !0.02704582_pr, & ! C2H3
      !0.04102934_pr, & ! HCCO
      !0.01402688_pr & ! CH2GL1G
       /)
  
contains

  ! ----------------------------------------------- !
  ! Subroutine for pressure dependent coefficients  !
  ! ----------------------------------------------- !
  real(pr) function getlindratecoeff(Tloc,k0,kinf,fc,concin,Ploc)
    implicit none

    real(pr) ::  Tloc,k0,kinf,fc,Ploc
    real(pr) :: ntmp,ccoeff,dcoeff,lgknull
    real(pr) :: f
    real(pr) :: conc, concin

    if (concin.gt.0.0_pr) then
       conc = concin
    else
       conc = Ploc / ( Rcst * Tloc )
    end if

    ntmp = 0.75_pr - 1.27_pr * log10( fc )
    ccoeff = - 0.4_pr - 0.67_pr * log10( fc )
    dcoeff = 0.14_pr
    k0 = abs(k0) * conc / max(abs(kinf), tiny(1.0_pr)) + tiny(1.0_pr)
    lgknull = log10(k0)
    f = (lgknull+ccoeff)/(ntmp-dcoeff*(lgknull+ccoeff))
    f = fc**(1.0_pr / ( f * f + 1.0_pr ))
    getlindratecoeff = kinf * f * k0 / ( 1.0_pr + k0 )

  end function getlindratecoeff

  ! ----------------------------------------------- !
  ! Evaluate thirdbodies                            !
  ! ----------------------------------------------- !
  subroutine get_thirdbodies(M,c)
    implicit none

    real(pr), dimension(nspec) :: c
    real(pr), dimension(nTB + nFO) :: M

    M(mM1) = (1_pr)*c(sCH4) &
         + (0.9_pr)*c(sCO) &
         + (2.8_pr)*c(sCO2) &
         + (1.5_pr)*c(sH2) &
         + (11_pr)*c(sH2O) &
         + sum(c)

    M(mM4) = (1_pr)*c(sCH4) &
         + (0.9_pr)*c(sCO) &
         + (2.8_pr)*c(sCO2) &
         + (1.5_pr)*c(sH2) &
         + (11_pr)*c(sH2O) &
         + sum(c)

    M(mM6) = (1_pr)*c(sCH4) &
         + (-0.27_pr)*c(sH2) &
         + (2.65_pr)*c(sH2O) &
         + sum(c)

    M(mM8) = (1_pr)*c(sCH4) &
         + (0.5_pr)*c(sCO) &
         + (1_pr)*c(sCO2) &
         + (1.5_pr)*c(sH2) &
         + (11_pr)*c(sH2O) &
         + sum(c)

    M(mM65) = (1_pr)*c(sCH4) &
         + (0.5_pr)*c(sCO) &
         + (1_pr)*c(sCO2) &
         + (1_pr)*c(sH2) &
         + (5_pr)*c(sH2O) &
         + sum(c)

    M(mM88) = (1_pr)*c(sCH4) &
         + (0.5_pr)*c(sCO) &
         + (1_pr)*c(sCO2) &
         + (1_pr)*c(sH2) &
         + (5_pr)*c(sH2O) &
         + sum(c)

    M(mM126) = sum(c)

    M(mM146) = sum(c)

    M(mM9) = (1.8_pr)*c(sCO) &
         + (0.6_pr)*c(sCO2) &
         + (2.7_pr)*c(sH2) &
         + (6.65_pr)*c(sH2O) &
         + (0.5_pr)*c(sN2) &
         + (0.2_pr)*c(sO2) &
         + sum(c)

    M(mM22) = (1_pr)*c(sCH4) &
         + (0.9_pr)*c(sCO) &
         + (2.8_pr)*c(sCO2) &
         + (0.3_pr)*c(sH2) &
         + (9_pr)*c(sH2O) &
         + sum(c)

    M(mM23) = (0.75_pr)*c(sCO) &
         + (2.6_pr)*c(sCO2) &
         + (1_pr)*c(sH2) &
         + (11_pr)*c(sH2O) &
         + sum(c)

    M(mM28) = (1_pr)*c(sCH4) &
         + (0.5_pr)*c(sCO) &
         + (1_pr)*c(sCO2) &
         + (1_pr)*c(sH2) &
         + (5_pr)*c(sH2O) &
         + sum(c)

    M(mM42) = (1_pr)*c(sCH4) &
         + (0.5_pr)*c(sCO) &
         + (1_pr)*c(sCO2) &
         + (1_pr)*c(sH2) &
         + (5_pr)*c(sH2O) &
         + sum(c)

    M(mM58) = (1_pr)*c(sCH4) &
         + (0.5_pr)*c(sCO) &
         + (1_pr)*c(sCO2) &
         + (1_pr)*c(sH2) &
         + (5_pr)*c(sH2O) &
         + sum(c)

    M(mM59) = (1_pr)*c(sCH4) &
         + (0.5_pr)*c(sCO) &
         + (1_pr)*c(sCO2) &
         + (1_pr)*c(sH2) &
         + (5_pr)*c(sH2O) &
         + sum(c)

    M(mM73) = (1_pr)*c(sCH4) &
         + (0.5_pr)*c(sCO) &
         + (1_pr)*c(sCO2) &
         + (1_pr)*c(sH2) &
         + (5_pr)*c(sH2O) &
         + sum(c)

    M(mM74) = (1_pr)*c(sCO) &
         + (2_pr)*c(sCO2) &
         + (4_pr)*c(sH2O) &
         + sum(c)

    M(mM75) = (1_pr)*c(sCH4) &
         + (0.5_pr)*c(sCO) &
         + (1_pr)*c(sCO2) &
         + (1_pr)*c(sH2) &
         + (5_pr)*c(sH2O) &
         + sum(c)

    M(mM82) = (1_pr)*c(sCH4) &
         + (0.5_pr)*c(sCO) &
         + (1_pr)*c(sCO2) &
         + (1_pr)*c(sH2) &
         + (5_pr)*c(sH2O) &
         + sum(c)

    M(mM87) = (1_pr)*c(sCH4) &
         + (0.5_pr)*c(sCO) &
         + (1_pr)*c(sCO2) &
         + (1_pr)*c(sH2) &
         + (5_pr)*c(sH2O) &
         + sum(c)

    M(mM97) = (1_pr)*c(sCH4) &
         + (0.5_pr)*c(sCO) &
         + (1_pr)*c(sCO2) &
         + (1_pr)*c(sH2) &
         + (5_pr)*c(sH2O) &
         + sum(c)

  end subroutine get_thirdbodies
  
  ! ----------------------------------------------- !
  ! Evaluate rate coefficients                      !
  ! ----------------------------------------------- !  
  subroutine get_rate_coefficients(k,M,Tloc,Ploc)
    implicit none
      
    real(pr), dimension(nreac + nreac_reverse) :: k
    real(pr), dimension(nFO + nFO_reverse) :: k_0
    real(pr), dimension(nFO + nFO_reverse) :: k_inf
    real(pr), dimension(nFO + nFO_reverse) :: FC
    real(pr), dimension(nTB + nFO) :: M
    real(pr) :: Tloc,Ploc,R_T_inv,T_log

    ! Rate coefficients
    R_T_inv = 1.0_pr/(Rcst*Tloc)
    T_log = log(Tloc)

    k(r1f) = (45770000000000_pr)*exp((-436809.6_pr)*R_T_inv + T_log *(-1.4_pr))
    k(r2f) = (0.0508_pr)*exp((-26325.728_pr)*R_T_inv + T_log *(2.67_pr))
    k(r3f) = (43800000_pr)*exp((-29246.16_pr)*R_T_inv)
    k(r4f) = (6165_pr)*exp(T_log *(-0.5_pr))
    k(r5f) = (114000000_pr)*exp((-63956.624_pr)*R_T_inv)
    k(r6f) = (35000000000_pr)*exp(T_log *(-2_pr))
    k(r7f) = (67_pr)*exp((-62704.7712_pr)*R_T_inv + T_log *(1.704_pr))
    k(r8f) = (4714000_pr)*exp(T_log *(-1_pr))
    k_0(FOr9f) = (2.49e+18_pr)*exp((-203965.816_pr)*R_T_inv + T_log *(-2.3_pr))
    k_inf(FOr9f) = (2000000000000_pr)*exp((-203965.816_pr)*R_T_inv + T_log *(0.9_pr))
    FC(FOr9f) = ((1.0_pr - 0.43_pr)*exp(-Tloc/(1e-30_pr))) + (0.43_pr*exp(-Tloc/(1e+30_pr)))
    k(r9f) = getlindratecoeff(Tloc,k_0(FOr9f),k_inf(FOr9f),FC(FOr9f), M(mM9),Ploc)
    k(r10f) = (24100000_pr)*exp((-16610.48_pr)*R_T_inv)
    k(r11f) = (21500_pr)*exp((-25104_pr)*R_T_inv + T_log *(1_pr))
    k(r12f) = (9.55_pr)*exp((-16610.48_pr)*R_T_inv + T_log *(2_pr))
    k(r13f) = (1740000_pr)*exp((-1330.512_pr)*R_T_inv)
    k(r14f) = (75900000_pr)*exp((-30413.496_pr)*R_T_inv)
    k(r15f) = (70790000_pr)*exp((-1234.28_pr)*R_T_inv)
    k(r16f) = (11402_pr)*exp((-2317.01552_pr)*R_T_inv + T_log *(1.083_pr))
    k(r17f) = (32500000_pr)
    k(r18f) = (7000000_pr)*exp((4572.94464_pr)*R_T_inv)
    k(r19f) = (450000000_pr)*exp((-45729.4464_pr)*R_T_inv)
    k(r20f) = (100000000_pr)*exp((-46195.04192_pr)*R_T_inv)
    k(r21f) = (190000_pr)*exp((5894.92128_pr)*R_T_inv)
    k_0(FOr22f) = (17400000_pr)*exp(T_log *(-1.23_pr))
    k_inf(FOr22f) = (4650000_pr)*exp(T_log *(0.44_pr))
    FC(FOr22f) = ((1.0_pr - 0.67_pr)*exp(-Tloc/(1e-30_pr))) + (0.67_pr*exp(-Tloc/(1e+30_pr)))&
              + exp(-(1e+30_pr)/Tloc)
    k(r22f) = getlindratecoeff(Tloc,k_0(FOr22f),k_inf(FOr22f),FC(FOr22f), M(mM22),Ploc)
    k_0(FOr23f) = (1170000000000_pr)*exp((-17535.144_pr)*R_T_inv + T_log *(-2.79_pr))
    k_inf(FOr23f) = (13620_pr)*exp((-9974.656_pr)*R_T_inv)
    k(r23f) = getlindratecoeff(Tloc,k_0(FOr23f),k_inf(FOr23f),1.0_pr, M(mM23),Ploc)
    k(r24f) = (0.07015_pr)*exp((1488.2488_pr)*R_T_inv + T_log *(2.053_pr))
    k(r25f) = (5757000_pr)*exp((-1388.2512_pr)*R_T_inv + T_log *(-0.664_pr))
    k(r26f) = (0.157_pr)*exp((-75060.96_pr)*R_T_inv + T_log *(2.18_pr))
    k(r27f) = (1119000_pr)*exp((-199576.8_pr)*R_T_inv)
    k_0(FOr28f) = (2.48e+21_pr)*exp((-10208.96_pr)*R_T_inv + T_log *(-4.76_pr))
    k_inf(FOr28f) = (12700000000_pr)*exp((-1602.472_pr)*R_T_inv + T_log *(-0.63_pr))
    FC(FOr28f) = ((1.0_pr - 0.783_pr)*exp(-Tloc/(74_pr))) + (0.783_pr*exp(-Tloc/(2941_pr)))&
              + exp(-(6964_pr)/Tloc)
    k(r28f) = getlindratecoeff(Tloc,k_0(FOr28f),k_inf(FOr28f),FC(FOr28f), M(mM28),Ploc)
    k(r29f) = (0.614_pr)*exp((-40112.008_pr)*R_T_inv + T_log *(2.5_pr))
    k(r30f) = (1020_pr)*exp((-35982.4_pr)*R_T_inv + T_log *(1.5_pr))
    k(r31f) = (0.0583_pr)*exp((-9162.96_pr)*R_T_inv + T_log *(2.6_pr))
    k(r32f) = (1.13e-05_pr)*exp((-87905.84_pr)*R_T_inv + T_log *(3.74_pr))
    k(r33f) = (0.116_pr)*exp((12644.048_pr)*R_T_inv + T_log *(2.23_pr))
    k(r34f) = (2.103555_pr)*exp((-34605.294976_pr)*R_T_inv + T_log *(2.013492_pr))
    k(r35f) = (14610340_pr)*exp((-599.123696_pr)*R_T_inv + T_log *(-0.2973165_pr))
    k(r36f) = (6261573_pr)*exp((-599.123696_pr)*R_T_inv + T_log *(-0.2973165_pr))
    k(r37f) = (7826966_pr)*exp((-599.123696_pr)*R_T_inv + T_log *(-0.2973165_pr))
    k(r38f) = (7826966_pr)*exp((-599.123696_pr)*R_T_inv + T_log *(-0.2973165_pr))
    k(r39f) = (36525840_pr)*exp((-599.123696_pr)*R_T_inv + T_log *(-0.2973165_pr))
    k(r40f) = (15653930_pr)*exp((-599.123696_pr)*R_T_inv + T_log *(-0.2973165_pr))
    k(r41f) = (7305169_pr)*exp((-599.123696_pr)*R_T_inv + T_log *(-0.2973165_pr))
    k_0(FOr42f) = (2.736332e+15_pr)*exp((-5149.934976_pr)*R_T_inv + T_log *(-3.126508_pr))
    k_inf(FOr42f) = (21377590000_pr)*exp((-3.615641256_pr)*R_T_inv + T_log *(-0.7865077_pr))
    FC(FOr42f) = ((1.0_pr - 0.68_pr)*exp(-Tloc/(78_pr))) + (0.68_pr*exp(-Tloc/(1995_pr)))&
              + exp(-(5590_pr)/Tloc)
    k(r42f) = getlindratecoeff(Tloc,k_0(FOr42f),k_inf(FOr42f),FC(FOr42f), M(mM42),Ploc)
    k(r43f) = (9064100_pr)*exp((-6279.614976_pr)*R_T_inv + T_log *(0.01349225_pr))
    k(r44f) = (2257474_pr)*exp((-6279.614976_pr)*R_T_inv + T_log *(0.01349225_pr))
    k(r45f) = (42755190_pr)*exp((-3.615641256_pr)*R_T_inv + T_log *(0.01349225_pr))
    k(r46f) = (7546000_pr)*exp((-118490.88_pr)*R_T_inv)
    k(r47f) = (2.641e-06_pr)*exp((-33911.32_pr)*R_T_inv + T_log *(3.283_pr))
    k(r48f) = (55400000_pr)*exp((569.024_pr)*R_T_inv + T_log *(0.05_pr))
    k(r49f) = (528200000000_pr)*exp((-7414.048_pr)*R_T_inv + T_log *(-1.518_pr))
    k(r50f) = (16.5_pr)*exp((8409.84_pr)*R_T_inv + T_log *(0.973_pr))
    k(r51f) = (1230_pr)*exp((-49998.8_pr)*R_T_inv + T_log *(1.011_pr))
    k(r52f) = (0.04293_pr)*exp((-16726.7952_pr)*R_T_inv + T_log *(2.568_pr))
    k(r53f) = (1000000_pr)*exp((2876.5_pr)*R_T_inv + T_log *(0.269_pr))
    k(r54f) = (4.38e-25_pr)*exp((23016.184_pr)*R_T_inv + T_log *(9.5_pr))
    k(r55f) = (20000000_pr)
    k(r56f) = (301000_pr)
    k(r57f) = (12000000_pr)
    k_0(FOr58f) = (1350000000000_pr)*exp((-5962.2_pr)*R_T_inv + T_log *(-2.57_pr))
    k_inf(FOr58f) = (1090000_pr)*exp((1087.84_pr)*R_T_inv + T_log *(0.48_pr))
    FC(FOr58f) = ((1.0_pr - 0.7824_pr)*exp(-Tloc/(271_pr))) + (0.7824_pr*exp(-Tloc/(2755_pr)))&
              + exp(-(6570_pr)/Tloc)
    k(r58f) = getlindratecoeff(Tloc,k_0(FOr58f),k_inf(FOr58f),FC(FOr58f), M(mM58),Ploc)
    k_0(FOr59f) = (5.07e+15_pr)*exp((-352912.032_pr)*R_T_inv + T_log *(-3.42_pr))
    k_inf(FOr59f) = (43_pr)*exp((-333046.4_pr)*R_T_inv + T_log *(1.5_pr))
    FC(FOr59f) = ((1.0_pr - 0.932_pr)*exp(-Tloc/(197_pr))) + (0.932_pr*exp(-Tloc/(1540_pr)))&
              + exp(-(10300_pr)/Tloc)
    k(r59f) = getlindratecoeff(Tloc,k_0(FOr59f),k_inf(FOr59f),FC(FOr59f), M(mM59),Ploc)
    k(r60f) = (8070000000_pr)*exp((-223509.28_pr)*R_T_inv)
    k(r61f) = (6260_pr)*exp((-9455.84_pr)*R_T_inv + T_log *(1.15_pr))
    k(r62f) = (57.4_pr)*exp((-11464.16_pr)*R_T_inv + T_log *(1.9_pr))
    k(r63f) = (78.2_pr)*exp((4414.12_pr)*R_T_inv + T_log *(1.63_pr))
    k(r64f) = (3.83e-05_pr)*exp((-18041.408_pr)*R_T_inv + T_log *(3.36_pr))
    k(r65f) = (570000_pr)*exp((-62216.08_pr)*R_T_inv + T_log *(0.66_pr))
    k(r66f) = (7580000_pr)*exp((-1715.44_pr)*R_T_inv)
    k(r67f) = (30200000_pr)
    k(r68f) = (73400000_pr)
    k(r69f) = (30110000_pr)
    k(r70f) = (26500000_pr)
    k(r71f) = (30000000_pr)
    k(r72f) = (30000000_pr)
    k_0(FOr73f) = (1.87e+19_pr)*exp((-101700.488_pr)*R_T_inv + T_log *(-3_pr))
    k_inf(FOr73f) = (68000000000000_pr)*exp((-109495.28_pr)*R_T_inv)
    FC(FOr73f) = ((1.0_pr - 0.9_pr)*exp(-Tloc/(2500_pr))) + (0.9_pr*exp(-Tloc/(1300_pr)))&
              + exp(-(1e+99_pr)/Tloc)
    k(r73f) = getlindratecoeff(Tloc,k_0(FOr73f),k_inf(FOr73f),FC(FOr73f), M(mM73),Ploc)
    k_0(FOr74f) = (8.05e+19_pr)*exp((-4107.0144_pr)*R_T_inv + T_log *(-3.75_pr))
    k_inf(FOr74f) = (2277000000_pr)*exp((-731.7816_pr)*R_T_inv + T_log *(-0.69_pr))
    FC(FOr74f) = ((1.0_pr - 0_pr)*exp(-Tloc/(570_pr))) + (0_pr*exp(-Tloc/(1e+30_pr)))&
              + exp(-(1e+30_pr)/Tloc)
    k(r74f) = getlindratecoeff(Tloc,k_0(FOr74f),k_inf(FOr74f),FC(FOr74f), M(mM74),Ploc)
    k_0(FOr75f) = (1.99e+29_pr)*exp((-27970.04_pr)*R_T_inv + T_log *(-7.08_pr))
    k_inf(FOr75f) = (521000000000_pr)*exp((-6610.72_pr)*R_T_inv + T_log *(-0.99_pr))
    FC(FOr75f) = ((1.0_pr - 0.842_pr)*exp(-Tloc/(125_pr))) + (0.842_pr*exp(-Tloc/(2219_pr)))&
              + exp(-(6882_pr)/Tloc)
    k(r75f) = getlindratecoeff(Tloc,k_0(FOr75f),k_inf(FOr75f),FC(FOr75f), M(mM75),Ploc)
    k(r76f) = (60300000_pr)*exp((-217024.08_pr)*R_T_inv)
    k(r77f) = (3.55_pr)*exp((-24392.72_pr)*R_T_inv + T_log *(2.4_pr))
    k(r78f) = (115_pr)*exp((-31505.52_pr)*R_T_inv + T_log *(1.9_pr))
    k(r79f) = (14.8_pr)*exp((-3974.8_pr)*R_T_inv + T_log *(1.9_pr))
    k(r80f) = (62615730_pr)*exp((-599.123696_pr)*R_T_inv + T_log *(-0.2973165_pr))
    k(r81f) = (5.55e-10_pr)*exp((-13518.504_pr)*R_T_inv + T_log *(4.72_pr))
    k_0(FOr82f) = (1.42e+27_pr)*exp((-24137.496_pr)*R_T_inv + T_log *(-6.642_pr))
    k_inf(FOr82f) = (956.9_pr)*exp((-5669.32_pr)*R_T_inv + T_log *(1.463_pr))
    FC(FOr82f) = ((1.0_pr - -0.569_pr)*exp(-Tloc/(299_pr))) + (-0.569_pr*exp(-Tloc/(-9147_pr)))&
              + exp(-(152.4_pr)/Tloc)
    k(r82f) = getlindratecoeff(Tloc,k_0(FOr82f),k_inf(FOr82f),FC(FOr82f), M(mM82),Ploc)
    k(r83f) = (2000000_pr)
    k(r84f) = (0.0118_pr)*exp((12221.464_pr)*R_T_inv + T_log *(2.45_pr))
    k(r85f) = (310000000_pr)*exp((-55950.54_pr)*R_T_inv + T_log *(-0.362_pr))
    k(r86f) = (18.43_pr)*exp((3014.9904_pr)*R_T_inv + T_log *(1.13_pr))
    k_0(FOr87f) = (1.4e+18_pr)*exp((-13890.88_pr)*R_T_inv + T_log *(-3.86_pr))
    k_inf(FOr87f) = (6080000_pr)*exp((-1171.52_pr)*R_T_inv + T_log *(0.27_pr))
    FC(FOr87f) = ((1.0_pr - 0.782_pr)*exp(-Tloc/(207.5_pr))) + (0.782_pr*exp(-Tloc/(2663_pr)))&
              + exp(-(6095_pr)/Tloc)
    k(r87f) = getlindratecoeff(Tloc,k_0(FOr87f),k_inf(FOr87f),FC(FOr87f), M(mM87),Ploc)
    k(r88f) = (26100000000_pr)*exp((-283771.432_pr)*R_T_inv)
    k(r89f) = (42200000_pr)*exp((-241095.0504_pr)*R_T_inv)
    k(r90f) = (50.7_pr)*exp((-54182.8_pr)*R_T_inv + T_log *(1.93_pr))
    k(r91f) = (0.0223_pr)*exp((-9269.652_pr)*R_T_inv + T_log *(2.745_pr))
    k(r92f) = (0.000976_pr)*exp((-63379.232_pr)*R_T_inv + T_log *(2.947_pr))
    k(r93f) = (8.13e-11_pr)*exp((-36968.9872_pr)*R_T_inv + T_log *(4.417_pr))
    k(r94f) = (7.453_pr)*exp((-765.672_pr)*R_T_inv + T_log *(1.88_pr))
    k(r95f) = (10435960_pr)*exp((-599.123696_pr)*R_T_inv + T_log *(-0.2973165_pr))
    k(r96f) = (0.178_pr)*exp((-8621.132_pr)*R_T_inv + T_log *(1.68_pr))
    k_0(FOr97f) = (6.35e+19_pr)*exp((-15815.52_pr)*R_T_inv + T_log *(-4.664_pr))
    k_inf(FOr97f) = (17100_pr)*exp((-11334.456_pr)*R_T_inv + T_log *(1.266_pr))
    FC(FOr97f) = ((1.0_pr - 0.788_pr)*exp(-Tloc/(-10200_pr))) + (0.788_pr*exp(-Tloc/(1e-30_pr)))
    k(r97f) = getlindratecoeff(Tloc,k_0(FOr97f),k_inf(FOr97f),FC(FOr97f), M(mM97),Ploc)
    k(r98f) = (21.5_pr)*exp((-14087.528_pr)*R_T_inv + T_log *(1.19_pr))
    k(r99f) = (4.6e-05_pr)*exp((2061.8752_pr)*R_T_inv + T_log *(2.76_pr))
    k(r100f) = (2.73e+29_pr)*exp((-49454.88_pr)*R_T_inv + T_log *(-7.32_pr))
    k(r101f) = (6080000000_pr)*exp((-2701.6088_pr)*R_T_inv + T_log *(-1.31_pr))
    k(r102f) = (6.36e+29_pr)*exp((-49454.88_pr)*R_T_inv + T_log *(-7.32_pr))
    k(r103f) = (14200000000_pr)*exp((-2701.6088_pr)*R_T_inv + T_log *(-1.31_pr))
    k(r104f) = (103000_pr)*exp((3128.7952_pr)*R_T_inv + T_log *(-0.33_pr))
    k(r105f) = (5.77e+15_pr)*exp((-19966.048_pr)*R_T_inv + T_log *(-3.54_pr))
    k(r106f) = (7.25e+25_pr)*exp((-43680.96_pr)*R_T_inv + T_log *(-6.7_pr))
    k(r107f) = (53200000_pr)*exp((-1868.9928_pr)*R_T_inv + T_log *(-1.14_pr))
    k(r108f) = (96353000_pr)
    k(r109f) = (30110000_pr)
    k(r110f) = (392000_pr)
    k(r111f) = (739.5_pr)*exp((-10342.848_pr)*R_T_inv + T_log *(1.28_pr))
    k(r112f) = (2958_pr)*exp((-10342.848_pr)*R_T_inv + T_log *(1.28_pr))
    k(r113f) = (10_pr)*exp((-25104_pr)*R_T_inv + T_log *(2_pr))
    k(r114f) = (1277_pr)*exp((-10790.536_pr)*R_T_inv + T_log *(0.73_pr))
    k(r115f) = (100000000_pr)
    k(r116f) = (80000000_pr)
    k(r117f) = (100000000_pr)
    k(r118f) = (191000_pr)*exp((-4267.68_pr)*R_T_inv + T_log *(-0.02_pr))
    k(r119f) = (4780000_pr)*exp((-4811.6_pr)*R_T_inv + T_log *(-0.142_pr))
    k(r120f) = (4.16e+18_pr)*exp((-40835.84_pr)*R_T_inv + T_log *(-3.19_pr))
    k(r121f) = (4920_pr)*exp((-2509.43768_pr)*R_T_inv + T_log *(1.02_pr))
    k(r122f) = (14200_pr)*exp((-16460.6928_pr)*R_T_inv + T_log *(0.209_pr))
    k(r123f) = (10000000_pr)
    k(r124f) = (240000_pr)*exp((3573.136_pr)*R_T_inv)
    k(r125f) = (20_pr)*exp((-125520_pr)*R_T_inv + T_log *(1.5_pr))
    k(r126f) = (10000_pr)
    k(r127f) = (100000000_pr)*exp((-100416_pr)*R_T_inv)
    k(r128f) = (10000000_pr)*exp((-112968_pr)*R_T_inv)
    k(r129f) = (5000000_pr)
    k(r130f) = (42755190_pr)*exp((-3.615641256_pr)*R_T_inv + T_log *(0.01349225_pr))
    k(r131f) = (25653110_pr)*exp((-3.615641256_pr)*R_T_inv + T_log *(0.01349225_pr))
    k(r132f) = (94061.42_pr)*exp((-4187.614976_pr)*R_T_inv + T_log *(0.01349225_pr))
    k(r133f) = (15653930_pr)*exp((-599.123696_pr)*R_T_inv + T_log *(-0.2973165_pr))
    k(r134f) = (22437300_pr)*exp((-599.123696_pr)*R_T_inv + T_log *(-0.2973165_pr))
    k(r135f) = (500000000_pr)*exp((-133888_pr)*R_T_inv)
    k(r136f) = (30000000000000_pr)*exp((-328444_pr)*R_T_inv)
    k(r137f) = (20000000_pr)*exp((-20920_pr)*R_T_inv)
    k(r138f) = (100000_pr)
    k(r139f) = (5000000_pr)*exp((-62760_pr)*R_T_inv)
    k(r140f) = (500000_pr)*exp((-33472_pr)*R_T_inv)
    k(r141f) = (500000_pr)*exp((-27196_pr)*R_T_inv)
    k(r142f) = (300000_pr)*exp((-108784_pr)*R_T_inv)
    k(r143f) = (100000000_pr)*exp((-200832_pr)*R_T_inv)
    k(r144f) = (300000_pr)*exp((-112968_pr)*R_T_inv)
    k(r145f) = (100000000_pr)*exp((-179912_pr)*R_T_inv)
    k(r146f) = (50000_pr)
    k(r147f) = (400000_pr)
    k(r148f) = (15000000_pr)
    k(r149f) = (0.6102_pr)*exp((-23869.13424_pr)*R_T_inv + T_log *(2_pr))
    k(r150f) = (1.134_pr)*exp((-64466.90464_pr)*R_T_inv + T_log *(2_pr))
    k(r151f) = (0.16_pr)*exp((-53575.53424_pr)*R_T_inv + T_log *(2_pr))
    k(r152f) = (18.8_pr)*exp((-33712.70552_pr)*R_T_inv + T_log *(2_pr))
    k(r153f) = (6.4_pr)*exp((-104131.22464_pr)*R_T_inv + T_log *(2_pr))
    k(r154f) = (0.16_pr)*exp((-22208.50464_pr)*R_T_inv + T_log *(2_pr))
    k(r1b) = (166690458.140193_pr)*exp((-3773.26485552121_pr)*R_T_inv + T_log *(-1.72447694002416_pr))
    k(r2b) = (0.0266917901835044_pr)*exp((-20176.9788791153_pr)*R_T_inv + T_log *(2.64944280333721_pr))
    k(r3b) = (250184119.400613_pr)*exp((-91371.565627841_pr)*R_T_inv + T_log *(-0.0268745284629498_pr))
    k(r4b) = (234529632067.839_pr)*exp((-497041.705082665_pr)*R_T_inv + T_log *(-0.552089709758102_pr))
    k(r5b) = (432338.922731592_pr)*exp((6197.49512014913_pr)*R_T_inv + T_log *(0.356009463938778_pr))
    k(r6b) = (5.48938742634943e+16_pr)*exp((-495161.740836115_pr)*R_T_inv + T_log *(-1.70239759983042_pr))
    k(r7b) = (6.16315515035332_pr)*exp((5569.38365467239_pr)*R_T_inv + T_log *(1.71031735079273_pr))
    k(r8b) = (680101508430.654_pr)*exp((-426887.586019583_pr)*R_T_inv + T_log *(-0.696080255948312_pr))
    k_0(FOr9b) = (24917068.0462671_pr)*exp((8361.97062615117_pr)*R_T_inv + T_log *(-1.42358113712498_pr))
    k_inf(FOr9b) = (20.0137124315436_pr)*exp((8361.97050947077_pr)*R_T_inv + T_log *(1.77641884244237_pr))
    FC(FOr9b) = ((1.0_pr - 0.43_pr)*exp(-Tloc/(1e-30_pr))) + (0.43_pr*exp(-Tloc/(1e+30_pr)))
    k(r9b) = getlindratecoeff(Tloc,k_0(FOr9b),k_inf(FOr9b),FC(FOr9b), M(mM9),Ploc)
    k(r10b) = (378.242656919347_pr)*exp((-299444.434265415_pr)*R_T_inv + T_log *(1.17402125318621_pr))
    k(r11b) = (169.269245065693_pr)*exp((-93502.0216893315_pr)*R_T_inv + T_log *(1.50073876108323_pr))
    k(r12b) = (0.0395054454417449_pr)*exp((-78859.7525752818_pr)*R_T_inv + T_log *(2.48018156321301_pr))
    k(r13b) = (78248.2334227885_pr)*exp((-131853.939429763_pr)*R_T_inv + T_log *(0.473864212501673_pr))
    k(r14b) = (3413241.9792277_pr)*exp((-160936.92344528_pr)*R_T_inv + T_log *(0.473864209718323_pr))
    k(r15b) = (24705.8649420498_pr)*exp((-153544.806803439_pr)*R_T_inv + T_log *(0.700157046412672_pr))
    k(r16b) = (1996.98925788178_pr)*exp((-230930.410590964_pr)*R_T_inv + T_log *(1.44770477425394_pr))
    k(r17b) = (2990832.2610684_pr)*exp((-222464.645972978_pr)*R_T_inv + T_log *(0.344147573560409_pr))
    k(r18b) = (7002908.083254_pr)*exp((-286165.856168464_pr)*R_T_inv + T_log *(0.337830226239869_pr))
    k(r19b) = (450186946.79681_pr)*exp((-336468.247206259_pr)*R_T_inv + T_log *(0.33783022664004_pr))
    k(r20b) = (2224615949.66989_pr)*exp((-206410.415221323_pr)*R_T_inv + T_log *(-0.136033972425291_pr))
    k(r21b) = (4226770.88042075_pr)*exp((-154320.452120439_pr)*R_T_inv + T_log *(-0.13603399014612_pr))
    k_0(FOr22b) = (27278765935578.4_pr)*exp((-204422.940058061_pr)*R_T_inv + T_log *(-1.27022783153545_pr))
    k_inf(FOr22b) = (7290014951723.26_pr)*exp((-204422.940049938_pr)*R_T_inv + T_log *(0.39977216994584_pr))
    FC(FOr22b) = ((1.0_pr - 0.67_pr)*exp(-Tloc/(1e-30_pr))) + (0.67_pr*exp(-Tloc/(1e+30_pr)))&
              + exp(-(1e+30_pr)/Tloc)
    k(r22b) = getlindratecoeff(Tloc,k_0(FOr22b),k_inf(FOr22b),FC(FOr22b), M(mM22),Ploc)
    k_0(FOr23b) = (2.93087107769461e+23_pr)*exp((-550813.225026227_pr)*R_T_inv + T_log *(-3.621777448521_pr))
    k_inf(FOr23b) = (3.41183471664252e+15_pr)*exp((-543252.737064287_pr)*R_T_inv + T_log *(-0.831777455398356_pr))
    k(r23b) = getlindratecoeff(Tloc,k_0(FOr23b),k_inf(FOr23b),1.0_pr, M(mM23),Ploc)
    k(r24b) = (121801.985556356_pr)*exp((-104902.246204482_pr)*R_T_inv + T_log *(0.91730280767534_pr))
    k(r25b) = (9995923563473.04_pr)*exp((-107778.746211996_pr)*R_T_inv + T_log *(-1.79969719364197_pr))
    k(r26b) = (95.1381064788482_pr)*exp((-333761.981820784_pr)*R_T_inv + T_log *(1.7444598517621_pr))
    k(r27b) = (7368451996.70956_pr)*exp((-235813.175875678_pr)*R_T_inv + T_log *(-0.77968772676929_pr))
    k_0(FOr28b) = (2.69157092685595e+29_pr)*exp((-449746.330732216_pr)*R_T_inv + T_log *(-4.78304878761954_pr))
    k_inf(FOr28b) = (1.37834479799178e+18_pr)*exp((-441139.842736548_pr)*R_T_inv + T_log *(-0.653048788449501_pr))
    FC(FOr28b) = ((1.0_pr - 0.783_pr)*exp(-Tloc/(74_pr))) + (0.783_pr*exp(-Tloc/(2941_pr)))&
              + exp(-(6964_pr)/Tloc)
    k(r28b) = getlindratecoeff(Tloc,k_0(FOr28b),k_inf(FOr28b),FC(FOr28b), M(mM28),Ploc)
    k(r29b) = (0.00155340388912676_pr)*exp((-33610.9723997186_pr)*R_T_inv + T_log *(2.84752572987445_pr))
    k(r30b) = (1.35590818776063_pr)*exp((-23332.6154557829_pr)*R_T_inv + T_log *(1.8269685020183_pr))
    k(r31b) = (0.000842500727971468_pr)*exp((-64787.3301694066_pr)*R_T_inv + T_log *(2.92065117614191_pr))
    k(r32b) = (3.63123927655154e-06_pr)*exp((-13006.7827172799_pr)*R_T_inv + T_log *(3.58678696756302_pr))
    k(r33b) = (8.03039223796204_pr)*exp((-222470.38283146_pr)*R_T_inv + T_log *(2.24717901626625_pr))
    k(r34b) = (1.22603849548369_pr)*exp((-59715.4274466813_pr)*R_T_inv + T_log *(1.93916479452816_pr))
    k(r36b) = (1283149.72090299_pr)*exp((-745609.568663651_pr)*R_T_inv + T_log *(0.19743165830702_pr))
    k(r37b) = (74042681.7617895_pr)*exp((-753638.282014529_pr)*R_T_inv + T_log *(-0.131703253593181_pr))
    k(r38b) = (1360392164.20693_pr)*exp((-385801.395547122_pr)*R_T_inv + T_log *(-0.701770193854146_pr))
    k(r39b) = (8414618361.21632_pr)*exp((-32210.2917556733_pr)*R_T_inv + T_log *(-0.719169433390567_pr))
    k(r40b) = (353702434665.53_pr)*exp((-326636.955050805_pr)*R_T_inv + T_log *(-0.858299216804465_pr))
    k(r41b) = (95064.4800480547_pr)*exp((-220246.460113808_pr)*R_T_inv + T_log *(0.277397963359015_pr))
    k_0(FOr42b) = (1.7309047866175e+23_pr)*exp((-469797.438190643_pr)*R_T_inv + T_log *(-3.22388399518476_pr))
    k_inf(FOr42b) = (1.35226914686164e+18_pr)*exp((-464651.11886705_pr)*R_T_inv + T_log *(-0.883883697051103_pr))
    FC(FOr42b) = ((1.0_pr - 0.68_pr)*exp(-Tloc/(78_pr))) + (0.68_pr*exp(-Tloc/(1995_pr)))&
              + exp(-(5590_pr)/Tloc)
    k(r42b) = getlindratecoeff(Tloc,k_0(FOr42b),k_inf(FOr42b),FC(FOr42b), M(mM42),Ploc)
    k(r43b) = (5974682.43853917_pr)*exp((-321327.767672683_pr)*R_T_inv + T_log *(-0.0349519737652331_pr))
    k(r46b) = (6799423285.54855_pr)*exp((1665.81803282267_pr)*R_T_inv + T_log *(-0.880273049843254_pr))
    k(r47b) = (5.16157611695042e-07_pr)*exp((-252035.115070126_pr)*R_T_inv + T_log *(3.47932248095537_pr))
    k(r48b) = (2854987366.16531_pr)*exp((-287708.890149618_pr)*R_T_inv + T_log *(-0.109686975736615_pr))
    k(r49b) = (13096338018.2082_pr)*exp((-37928.2856711306_pr)*R_T_inv + T_log *(-1.12302161350442_pr))
    k(r50b) = (1618.32001904356_pr)*exp((-286016.82331466_pr)*R_T_inv + T_log *(0.83387021305566_pr))
    k(r51b) = (292240399.91431_pr)*exp((3.78005607236884_pr)*R_T_inv + T_log *(-0.225282320459145_pr))
    k(r52b) = (0.001064418391524_pr)*exp((-47241.032875372_pr)*R_T_inv + T_log *(2.96297838573644_pr))
    k(r53b) = (82920892.5344432_pr)*exp((-99431.4479329905_pr)*R_T_inv + T_log *(-0.267125474777707_pr))
    k(r54b) = (1.03234314583644e-27_pr)*exp((-92799.6631392514_pr)*R_T_inv + T_log *(10.2324479553685_pr))
    k(r55b) = (8256.09425852895_pr)*exp((-344429.242188473_pr)*R_T_inv + T_log *(1.09715273362691_pr))
    k(r56b) = (15782.346117559_pr)*exp((-276031.220529719_pr)*R_T_inv + T_log *(0.596413967037189_pr))
    k(r57b) = (1957987.24799491_pr)*exp((-350930.277759603_pr)*R_T_inv + T_log *(0.749627008805588_pr))
    k_0(FOr58b) = (2.53198954951032e+19_pr)*exp((-373685.345511697_pr)*R_T_inv + T_log *(-2.4226092768464_pr))
    k_inf(FOr58b) = (20443470764606.4_pr)*exp((-366635.305497444_pr)*R_T_inv + T_log *(0.627390725796018_pr))
    FC(FOr58b) = ((1.0_pr - 0.7824_pr)*exp(-Tloc/(271_pr))) + (0.7824_pr*exp(-Tloc/(2755_pr)))&
              + exp(-(6570_pr)/Tloc)
    k(r58b) = getlindratecoeff(Tloc,k_0(FOr58b),k_inf(FOr58b),FC(FOr58b), M(mM58),Ploc)
    k_0(FOr59b) = (1.74710131400724e+24_pr)*exp((-352798.291051261_pr)*R_T_inv + T_log *(-3.84267622002472_pr))
    k_inf(FOr59b) = (14817624498.3462_pr)*exp((-332932.659048057_pr)*R_T_inv + T_log *(1.07732378047293_pr))
    FC(FOr59b) = ((1.0_pr - 0.932_pr)*exp(-Tloc/(197_pr))) + (0.932_pr*exp(-Tloc/(1540_pr)))&
              + exp(-(10300_pr)/Tloc)
    k(r59b) = getlindratecoeff(Tloc,k_0(FOr59b),k_inf(FOr59b),FC(FOr59b), M(mM59),Ploc)
    k(r60b) = (674560414.980562_pr)*exp((-60209.074523685_pr)*R_T_inv + T_log *(-0.187618550673994_pr))
    k(r61b) = (48.1537745241579_pr)*exp((-68620.2804778321_pr)*R_T_inv + T_log *(1.30652902625439_pr))
    k(r62b) = (0.8403378091444_pr)*exp((-76777.3495988018_pr)*R_T_inv + T_log *(2.07708622289469_pr))
    k(r63b) = (6.53934796057456_pr)*exp((-123024.475316104_pr)*R_T_inv + T_log *(1.78021167838966_pr))
    k(r64b) = (0.000221628070679986_pr)*exp((-89855.633194091_pr)*R_T_inv + T_log *(3.18956049386191_pr))
    k(r65b) = (0.112985500210287_pr)*exp((2983.36865010708_pr)*R_T_inv + T_log *(0.905589997230921_pr))
    k(r66b) = (2355551.16857495_pr)*exp((-140938.931422337_pr)*R_T_inv + T_log *(0.205362162998451_pr))
    k(r67b) = (863652.340751648_pr)*exp((-361688.137359719_pr)*R_T_inv + T_log *(0.549509742891023_pr))
    k(r68b) = (3994975.11616756_pr)*exp((-367836.886476048_pr)*R_T_inv + T_log *(0.570066940396767_pr))
    k(r69b) = (9360832.59560305_pr)*exp((-429962.292230885_pr)*R_T_inv + T_log *(0.543192389214384_pr))
    k(r70b) = (570095914.855571_pr)*exp((-374337.922165065_pr)*R_T_inv + T_log *(0.222541194529933_pr))
    k(r71b) = (1489635286572.32_pr)*exp((-468078.632351906_pr)*R_T_inv + T_log *(-0.586187447183536_pr))
    k_0(FOr73b) = (28113576100.9167_pr)*exp((-13093.3950619846_pr)*R_T_inv + T_log *(-2.22732420969308_pr))
    k_inf(FOr73b) = (102231.181903009_pr)*exp((-20888.1870340576_pr)*R_T_inv + T_log *(0.772675795288382_pr))
    FC(FOr73b) = ((1.0_pr - 0.9_pr)*exp(-Tloc/(2500_pr))) + (0.9_pr*exp(-Tloc/(1300_pr)))&
              + exp(-(1e+99_pr)/Tloc)
    k(r73b) = getlindratecoeff(Tloc,k_0(FOr73b),k_inf(FOr73b),FC(FOr73b), M(mM73),Ploc)
    k_0(FOr74b) = (9.08914595823316e+32_pr)*exp((-384985.90561259_pr)*R_T_inv + T_log *(-4.80146066484487_pr))
    k_inf(FOr74b) = (2.57092987262165e+22_pr)*exp((-381610.67281722_pr)*R_T_inv + T_log *(-1.74146066564172_pr))
    FC(FOr74b) = ((1.0_pr - 0_pr)*exp(-Tloc/(570_pr))) + (0_pr*exp(-Tloc/(1e+30_pr)))&
              + exp(-(1e+30_pr)/Tloc)
    k(r74b) = getlindratecoeff(Tloc,k_0(FOr74b),k_inf(FOr74b),FC(FOr74b), M(mM74),Ploc)
    k_0(FOr75b) = (4.5198518106728e+37_pr)*exp((-448996.901186175_pr)*R_T_inv + T_log *(-7.14986279748653_pr))
    k_inf(FOr75b) = (1.1833380923156e+20_pr)*exp((-427637.581189419_pr)*R_T_inv + T_log *(-1.05986279806284_pr))
    FC(FOr75b) = ((1.0_pr - 0.842_pr)*exp(-Tloc/(125_pr))) + (0.842_pr*exp(-Tloc/(2219_pr)))&
              + exp(-(6882_pr)/Tloc)
    k(r75b) = getlindratecoeff(Tloc,k_0(FOr75b),k_inf(FOr75b),FC(FOr75b), M(mM75),Ploc)
    k(r76b) = (416218.782319405_pr)*exp((-420.158929618961_pr)*R_T_inv + T_log *(0.0296349644415406_pr))
    k(r77b) = (0.0022549729611158_pr)*exp((-30253.444741071_pr)*R_T_inv + T_log *(2.77378255783417_pr))
    k(r78b) = (0.139026276493926_pr)*exp((-43514.9939558234_pr)*R_T_inv + T_log *(2.2943397379764_pr))
    k(r79b) = (0.102198963018145_pr)*exp((-78109.6797418546_pr)*R_T_inv + T_log *(2.26746518132843_pr))
    k(r80b) = (17438804.7047509_pr)*exp((-44219.7657178175_pr)*R_T_inv + T_log *(-0.324829696521602_pr))
    k(r81b) = (2.65201521907958e-10_pr)*exp((-32029.0135474272_pr)*R_T_inv + T_log *(4.76681400961768_pr))
    k_0(FOr82b) = (2.7627244135269e+33_pr)*exp((-173563.77877021_pr)*R_T_inv + T_log *(-6.71792779010927_pr))
    k_inf(FOr82b) = (1861726058.12048_pr)*exp((-155095.602773398_pr)*R_T_inv + T_log *(1.38707220934215_pr))
    FC(FOr82b) = ((1.0_pr - -0.569_pr)*exp(-Tloc/(299_pr))) + (-0.569_pr*exp(-Tloc/(-9147_pr)))&
              + exp(-(152.4_pr)/Tloc)
    k(r82b) = getlindratecoeff(Tloc,k_0(FOr82b),k_inf(FOr82b),FC(FOr82b), M(mM82),Ploc)
    k(r83b) = (282261.054853594_pr)*exp((-283610.052396766_pr)*R_T_inv + T_log *(0.400404726108805_pr))
    k(r84b) = (0.658243341411569_pr)*exp((-277889.623183849_pr)*R_T_inv + T_log *(2.50287913961956_pr))
    k(r85b) = (15410536626562.9_pr)*exp((-15802.5700111495_pr)*R_T_inv + T_log *(-1.34359786453782_pr))
    k(r86b) = (14.8508601367313_pr)*exp((-51981.666926313_pr)*R_T_inv + T_log *(1.16569995177781_pr))
    k_0(FOr87b) = (5.09406728559611e+26_pr)*exp((-475730.063774146_pr)*R_T_inv + T_log *(-3.98086370447164_pr))
    k_inf(FOr87b) = (2.21228096523606e+15_pr)*exp((-463010.703879593_pr)*R_T_inv + T_log *(0.14913627700502_pr))
    FC(FOr87b) = ((1.0_pr - 0.782_pr)*exp(-Tloc/(207.5_pr))) + (0.782_pr*exp(-Tloc/(2663_pr)))&
              + exp(-(6095_pr)/Tloc)
    k(r87b) = getlindratecoeff(Tloc,k_0(FOr87b),k_inf(FOr87b),FC(FOr87b), M(mM87),Ploc)
    k(r88b) = (871.443160528342_pr)*exp((-107297.471393514_pr)*R_T_inv + T_log *(-0.0229630199265741_pr))
    k(r89b) = (181824.049937679_pr)*exp((16321.1932387358_pr)*R_T_inv + T_log *(0.0806358590545845_pr))
    k(r90b) = (0.0382597037576184_pr)*exp((-25379.9515610285_pr)*R_T_inv + T_log *(2.3753406107815_pr))
    k(r91b) = (9.61222873281417e-05_pr)*exp((-42592.209122426_pr)*R_T_inv + T_log *(3.16346609378449_pr))
    k(r92b) = (0.000291116841261353_pr)*exp((-41077.4189682007_pr)*R_T_inv + T_log *(3.04481491494669_pr))
    k(r93b) = (2.42497940181905e-11_pr)*exp((-14667.1741608964_pr)*R_T_inv + T_log *(4.51481491622053_pr))
    k(r94b) = (0.000801476161529921_pr)*exp((-110894.693481136_pr)*R_T_inv + T_log *(2.47859236067453_pr))
    k(r95b) = (16867225040132.9_pr)*exp((-275672.374145854_pr)*R_T_inv + T_log *(-1.30036256865294_pr))
    k(r96b) = (0.00248841864444772_pr)*exp((-59585.712931577_pr)*R_T_inv + T_log *(2.12206334706525_pr))
    k_0(FOr97b) = (1.43518894860438e+24_pr)*exp((-163486.632619876_pr)*R_T_inv + T_log *(-4.19569645046986_pr))
    k_inf(FOr97b) = (386483951.701712_pr)*exp((-159005.568617096_pr)*R_T_inv + T_log *(1.73430354999207_pr))
    FC(FOr97b) = ((1.0_pr - 0.788_pr)*exp(-Tloc/(-10200_pr))) + (0.788_pr*exp(-Tloc/(1e-30_pr)))
    k(r97b) = getlindratecoeff(Tloc,k_0(FOr97b),k_inf(FOr97b),FC(FOr97b), M(mM97),Ploc)
    k(r98b) = (1491.34660456843_pr)*exp((-70839.3554633868_pr)*R_T_inv + T_log *(0.68146861445269_pr))
    k(r99b) = (0.00319078808733752_pr)*exp((-54689.9522641799_pr)*R_T_inv + T_log *(2.25146861432845_pr))
    k(r100b) = (1.44706654614078e+28_pr)*exp((-412659.294224168_pr)*R_T_inv + T_log *(-6.94986859242716_pr))
    k(r101b) = (322277086.976456_pr)*exp((-365906.023013701_pr)*R_T_inv + T_log *(-0.939868590558967_pr))
    k(r104b) = (719840.797909328_pr)*exp((-383483.263319348_pr)*R_T_inv + T_log *(-0.486954386963556_pr))
    k(r105b) = (4.03250616916466e+16_pr)*exp((-406578.106510735_pr)*R_T_inv + T_log *(-3.69695438540039_pr))
    k(r106b) = (3.70278176249935e+27_pr)*exp((-586686.092397025_pr)*R_T_inv + T_log *(-6.75636905861253_pr))
    k(r107b) = (2717075698.11573_pr)*exp((-544874.125191105_pr)*R_T_inv + T_log *(-1.1963690575196_pr))
    k(r108b) = (1170576957.4939_pr)*exp((-285365.222380243_pr)*R_T_inv + T_log *(-0.143826583670457_pr))
    k(r109b) = (2089446529.50044_pr)*exp((-347490.628254947_pr)*R_T_inv + T_log *(-0.170701156421489_pr))
    k(r110b) = (1882369644.93665_pr)*exp((-291866.258199791_pr)*R_T_inv + T_log *(-0.491352352795657_pr))
    k(r111b) = (0.00204933560434677_pr)*exp((-200135.213931968_pr)*R_T_inv + T_log *(2.56899821199138_pr))
    k(r112b) = (23082.5644618617_pr)*exp((-91823.633780088_pr)*R_T_inv + T_log *(0.966969003791373_pr))
    k(r113b) = (0.0448005379008571_pr)*exp((-107575.663994907_pr)*R_T_inv + T_log *(2.71389354220189_pr))
    k(r114b) = (1.55162228221463_pr)*exp((-238342.819082113_pr)*R_T_inv + T_log *(1.61770248057916_pr))
    k(r117b) = (35.5131363727529_pr)*exp((-108311.580167394_pr)*R_T_inv + T_log *(1.60202920535408_pr))
    k(r120b) = (7.23204436724061e+17_pr)*exp((-43644.1594451042_pr)*R_T_inv + T_log *(-3.16651229162135_pr))
    k(r121b) = (855.328322400034_pr)*exp((-5317.75712357617_pr)*R_T_inv + T_log *(1.0434877086526_pr))
    k(r122b) = (275484.277835369_pr)*exp((-110576.73101703_pr)*R_T_inv + T_log *(-0.0592544194894311_pr))
    k(r123b) = (0.00427834251529852_pr)*exp((-66626.2660097014_pr)*R_T_inv + T_log *(0.893655765429019_pr))
    k(r124b) = (97547.7202635915_pr)*exp((-526177.091905096_pr)*R_T_inv + T_log *(0.417887782654271_pr))
    k(r125b) = (0.591882493323566_pr)*exp((-136846.666875428_pr)*R_T_inv + T_log *(1.54297842989873_pr))
    k(r126b) = (4133861704507.61_pr)*exp((-274577.059106449_pr)*R_T_inv + T_log *(-0.396237282648274_pr))
    k(r130b) = (404461843.573903_pr)*exp((-753042.774007253_pr)*R_T_inv + T_log *(0.179105489592195_pr))
    k(r131b) = (579635070809.908_pr)*exp((-326041.446944543_pr)*R_T_inv + T_log *(-0.547490457645511_pr))
    k(r132b) = (1224.05098911938_pr)*exp((-223834.951341335_pr)*R_T_inv + T_log *(0.588206722737245_pr))
    k(r133b) = (539.314312485136_pr)*exp((-320601.946940903_pr)*R_T_inv + T_log *(-0.456180204734414_pr))
    k(r134b) = (13077382.8113561_pr)*exp((-25709.2561791127_pr)*R_T_inv + T_log *(-0.371643707665125_pr))
    k(r136b) = (18641.0790667931_pr)*exp((-191027.191125277_pr)*R_T_inv + T_log *(0.47026753888815_pr))
    k(r140b) = (481763943.39173_pr)*exp((-213272.718232592_pr)*R_T_inv + T_log *(-0.426500476860294_pr))
    k(r141b) = (3653935.180057_pr)*exp((-183589.073806618_pr)*R_T_inv + T_log *(0.100585341064298_pr))
    k(r147b) = (2765275.75631707_pr)*exp((-299438.864842772_pr)*R_T_inv + T_log *(0.0693281692743882_pr))
  
    return
  end subroutine get_rate_coefficients

  ! ----------------------------------------------- !
  ! Evaluate reaction rates                         !
  ! ----------------------------------------------- !
  subroutine get_reaction_rates(w,k,m,c,cqss)
    implicit none

    real(pr), dimension(nspec) :: c
    real(pr), dimension(nqss) :: cqss
    real(pr), dimension(nreac + nreac_reverse) :: w,k
    real(pr), dimension(nTB + nFO) :: m

    w(r1f) = k(r1f) * c(sH2) * m(mM1)
    w(r2f) = k(r2f) * c(sH2) * c(sO) 
    w(r3f) = k(r3f) * c(sH2) * c(sOH) 
    w(r4f) = k(r4f) * c(sO)**2.0_pr * m(mM4)
    w(r5f) = k(r5f) * c(sH) * c(sO2) 
    w(r6f) = k(r6f) * c(sH) * c(sOH) * m(mM6)
    w(r7f) = k(r7f) * c(sH2O) * c(sO) 
    w(r8f) = k(r8f) * c(sH) * c(sO) * m(mM8)
    w(r9f) = k(r9f) * cqss(sqssH2O2) 
    w(r10f) = k(r10f) * c(sH) * cqss(sqssH2O2) 
    w(r11f) = k(r11f) * c(sH) * cqss(sqssH2O2) 
    w(r12f) = k(r12f) * cqss(sqssH2O2) * c(sO) 
    w(r13f) = k(r13f) * cqss(sqssH2O2) * c(sOH) 
    w(r14f) = k(r14f) * cqss(sqssH2O2) * c(sOH) 
    w(r15f) = k(r15f) * c(sH) * c(sHO2) 
    w(r16f) = k(r16f) * c(sH) * c(sHO2) 
    w(r17f) = k(r17f) * c(sHO2) * c(sO) 
    w(r18f) = k(r18f) * c(sHO2) * c(sOH) 
    w(r19f) = k(r19f) * c(sHO2) * c(sOH) 
    w(r20f) = k(r20f) * c(sHO2)**2.0_pr 
    w(r21f) = k(r21f) * c(sHO2)**2.0_pr 
    w(r22f) = k(r22f) * c(sH) * c(sO2) 
    w(r23f) = k(r23f) * c(sCO) * c(sO) 
    w(r24f) = k(r24f) * c(sCO) * c(sOH) 
    w(r25f) = k(r25f) * c(sCO) * c(sOH) 
    w(r26f) = k(r26f) * c(sCO) * c(sHO2) 
    w(r27f) = k(r27f) * c(sCO) * c(sO2) 
    w(r28f) = k(r28f) * c(sCH3) * c(sH) 
    w(r29f) = k(r29f) * c(sCH4) * c(sH) 
    w(r30f) = k(r30f) * c(sCH4) * c(sO) 
    w(r31f) = k(r31f) * c(sCH4) * c(sOH) 
    w(r32f) = k(r32f) * c(sCH4) * c(sHO2) 
    w(r33f) = k(r33f) * c(sCH3) * c(sHO2) 
    w(r34f) = k(r34f) * cqss(sqssCH2GL1G) * c(sCH4) 
    w(r35f) = k(r35f) * cqss(sqssCH2GL1G) * c(sO2) 
    w(r36f) = k(r36f) * cqss(sqssCH2GL1G) * c(sO2) 
    w(r37f) = k(r37f) * cqss(sqssCH2GL1G) * c(sO) 
    w(r38f) = k(r38f) * cqss(sqssCH2GL1G) * c(sO) 
    w(r39f) = k(r39f) * cqss(sqssCH2GL1G) * c(sH2) 
    w(r40f) = k(r40f) * cqss(sqssCH2GL1G) * c(sOH) 
    w(r41f) = k(r41f) * cqss(sqssCH2GL1G) * c(sCO2) 
    w(r42f) = k(r42f) * cqss(sqssCH2GL1G) * c(sH) 
    w(r43f) = k(r43f) * cqss(sqssCH2GL1G) * c(sO2) 
    w(r44f) = k(r44f) * cqss(sqssCH2GL1G) * c(sO2) 
    w(r45f) = k(r45f) * cqss(sqssCH2GL1G) * c(sO) 
    w(r46f) = k(r46f) * c(sCH3) * c(sO2) 
    w(r47f) = k(r47f) * c(sCH3) * c(sO2) 
    w(r48f) = k(r48f) * c(sCH3) * c(sO) 
    w(r49f) = k(r49f) * c(sCH3) * c(sOH) 
    w(r50f) = k(r50f) * c(sCH3) * c(sOH) 
    w(r51f) = k(r51f) * c(sCH3) * c(sOH) 
    w(r52f) = k(r52f) * c(sCH3) * c(sOH) 
    w(r53f) = k(r53f) * c(sCH3) * c(sHO2) 
    w(r54f) = k(r54f) * cqss(sqssCH3O) * c(sO2) 
    w(r55f) = k(r55f) * cqss(sqssCH3O) * c(sH) 
    w(r56f) = k(r56f) * cqss(sqssCH3O) * c(sHO2) 
    w(r57f) = k(r57f) * c(sCH3) * cqss(sqssCH3O) 
    w(r58f) = k(r58f) * c(sH) * cqss(sqssHCO) 
    w(r59f) = k(r59f) * c(sCO) * c(sH2) 
    w(r60f) = k(r60f) * c(sCH2O) * c(sO2) 
    w(r61f) = k(r61f) * c(sCH2O) * c(sO) 
    w(r62f) = k(r62f) * c(sCH2O) * c(sH) 
    w(r63f) = k(r63f) * c(sCH2O) * c(sOH) 
    w(r64f) = k(r64f) * c(sCH2O) * c(sCH3) 
    w(r65f) = k(r65f) * cqss(sqssHCO) * m(mM65)
    w(r66f) = k(r66f) * cqss(sqssHCO) * c(sO2) 
    w(r67f) = k(r67f) * cqss(sqssHCO) * c(sO) 
    w(r68f) = k(r68f) * c(sH) * cqss(sqssHCO) 
    w(r69f) = k(r69f) * cqss(sqssHCO) * c(sOH) 
    w(r70f) = k(r70f) * c(sCH3) * cqss(sqssHCO) 
    w(r71f) = k(r71f) * cqss(sqssHCO) * c(sO) 
    w(r72f) = k(r72f) * cqss(sqssHCO) * c(sHO2) 
    w(r73f) = k(r73f) * cqss(sqssCH3O) 
    w(r74f) = k(r74f) * c(sCH3)**2.0_pr 
    w(r75f) = k(r75f) * cqss(sqssC2H5) * c(sH) 
    w(r76f) = k(r76f) * c(sC2H6) * c(sO2) 
    w(r77f) = k(r77f) * c(sC2H6) * c(sO) 
    w(r78f) = k(r78f) * c(sC2H6) * c(sH) 
    w(r79f) = k(r79f) * c(sC2H6) * c(sOH) 
    w(r80f) = k(r80f) * c(sC2H6) * cqss(sqssCH2GL1G) 
    w(r81f) = k(r81f) * c(sC2H6) * c(sCH3) 
    w(r82f) = k(r82f) * c(sC2H4) * c(sH) 
    w(r83f) = k(r83f) * cqss(sqssC2H5) * c(sH) 
    w(r84f) = k(r84f) * cqss(sqssC2H5) * c(sCH3) 
    w(r85f) = k(r85f) * c(sCH3)**2.0_pr 
    w(r86f) = k(r86f) * cqss(sqssC2H5) * c(sO2) 
    w(r87f) = k(r87f) * cqss(sqssC2H3) * c(sH) 
    w(r88f) = k(r88f) * c(sC2H4) * m(mM88)
    w(r89f) = k(r89f) * c(sC2H4) * c(sO2) 
    w(r90f) = k(r90f) * c(sC2H4) * c(sH) 
    w(r91f) = k(r91f) * c(sC2H4) * c(sOH) 
    w(r92f) = k(r92f) * c(sC2H4) * c(sCH3) 
    w(r93f) = k(r93f) * c(sC2H4) * c(sCH3) 
    w(r94f) = k(r94f) * c(sC2H4) * c(sO) 
    w(r95f) = k(r95f) * cqss(sqssCH2GL1G) * c(sCH3) 
    w(r96f) = k(r96f) * c(sC2H4) * c(sOH) 
    w(r97f) = k(r97f) * c(sC2H2) * c(sH) 
    w(r98f) = k(r98f) * cqss(sqssC2H3) * c(sO2) 
    w(r99f) = k(r99f) * cqss(sqssC2H3) * c(sO2) 
    w(r100f) = k(r100f) * cqss(sqssC2H3) * c(sO2) 
    w(r101f) = k(r101f) * cqss(sqssC2H3) * c(sO2) 
    w(r102f) = k(r102f) * cqss(sqssC2H3) * c(sO2) 
    w(r103f) = k(r103f) * cqss(sqssC2H3) * c(sO2) 
    w(r104f) = k(r104f) * cqss(sqssC2H3) * c(sO2) 
    w(r105f) = k(r105f) * cqss(sqssC2H3) * c(sO2) 
    w(r106f) = k(r106f) * cqss(sqssC2H3) * c(sO2) 
    w(r107f) = k(r107f) * cqss(sqssC2H3) * c(sO2) 
    w(r108f) = k(r108f) * cqss(sqssC2H3) * c(sH) 
    w(r109f) = k(r109f) * cqss(sqssC2H3) * c(sOH) 
    w(r110f) = k(r110f) * cqss(sqssC2H3) * c(sCH3) 
    w(r111f) = k(r111f) * c(sC2H2) * c(sO) 
    w(r112f) = k(r112f) * c(sC2H2) * c(sO) 
    w(r113f) = k(r113f) * c(sC2H2) * cqss(sqssHCO) 
    w(r114f) = k(r114f) * c(sC2H2) * c(sOH) 
    w(r115f) = k(r115f) * cqss(sqssHCCO) * c(sOH) 
    w(r116f) = k(r116f) * cqss(sqssHCCO) * c(sO) 
    w(r117f) = k(r117f) * c(sH) * cqss(sqssHCCO) 
    w(r118f) = k(r118f) * cqss(sqssHCCO) * c(sO2) 
    w(r119f) = k(r119f) * cqss(sqssHCCO) * c(sO2) 
    w(r120f) = k(r120f) * c(sC2H4) * cqss(sqssCH2GL1G) 
    w(r121f) = k(r121f) * c(sC2H4) * cqss(sqssCH2GL1G) 
    w(r122f) = k(r122f) * cqss(sqssC2H3) * c(sCH2O) 
    w(r123f) = k(r123f) * cqss(sqssHCCO) * c(sOH) 
    w(r124f) = k(r124f) * cqss(sqssHCCO) * c(sO2) 
    w(r125f) = k(r125f) * c(sC2H2) * c(sO2) 
    w(r126f) = k(r126f) * c(sO) * c(sOH) * m(mM126)
    w(r127f) = k(r127f) * cqss(sqssC2H5) * c(sO2) 
    w(r128f) = k(r128f) * cqss(sqssC2H5) * c(sO2) 
    w(r129f) = k(r129f) * cqss(sqssC2H5) * c(sHO2) 
    w(r130f) = k(r130f) * cqss(sqssCH2GL1G) * c(sO) 
    w(r131f) = k(r131f) * cqss(sqssCH2GL1G) * c(sOH) 
    w(r132f) = k(r132f) * cqss(sqssCH2GL1G) * c(sCO2) 
    w(r133f) = k(r133f) * cqss(sqssCH2GL1G) * c(sO) 
    w(r134f) = k(r134f) * cqss(sqssCH2GL1G) * c(sCH4) 
    w(r135f) = k(r135f) * c(sCH3)**2.0_pr 
    w(r136f) = k(r136f) * c(sC2H6) 
    w(r137f) = k(r137f) * c(sCH2O) * c(sO) 
    w(r138f) = k(r138f) * c(sCH2O) * c(sOH) 
    w(r139f) = k(r139f) * c(sC2H2) * c(sHO2) 
    w(r140f) = k(r140f) * c(sCH2O) * cqss(sqssHCO) 
    w(r141f) = k(r141f) * cqss(sqssCH3O) * c(sCO) 
    w(r142f) = k(r142f) * c(sC2H2) * c(sO2) 
    w(r143f) = k(r143f) * c(sC2H4) * c(sO2) 
    w(r144f) = k(r144f) * c(sC2H2) * c(sO2) 
    w(r145f) = k(r145f) * c(sC2H4) * c(sO2) 
    w(r146f) = k(r146f) * c(sCH3) * c(sO) * m(mM146)
    w(r147f) = k(r147f) * cqss(sqssHCO) * c(sHO2) 
    w(r148f) = k(r148f) * cqss(sqssCH3O) * c(sOH) 
    w(r149f) = k(r149f) * cqss(sqssC2H3) * c(sC2H6) 
    w(r150f) = k(r150f) * c(sC2H6) * cqss(sqssHCO) 
    w(r151f) = k(r151f) * c(sC2H4) * cqss(sqssC2H5) 
    w(r152f) = k(r152f) * c(sC2H4) * c(sO) 
    w(r153f) = k(r153f) * c(sC2H4) * c(sHO2) 
    w(r154f) = k(r154f) * cqss(sqssC2H5) * c(sCH2O) 
    w(r1b) = k(r1b) * c(sH)**2.0_pr * m(mM1)
    w(r2b) = k(r2b) * c(sH) * c(sOH) 
    w(r3b) = k(r3b) * c(sH) * c(sH2O) 
    w(r4b) = k(r4b) * c(sO2) * m(mM4)
    w(r5b) = k(r5b) * c(sO) * c(sOH) 
    w(r6b) = k(r6b) * c(sH2O) * m(mM6)
    w(r7b) = k(r7b) * c(sOH)**2.0_pr 
    w(r8b) = k(r8b) * c(sOH) * m(mM8)
    w(r9b) = k(r9b) * c(sOH)**2.0_pr 
    w(r10b) = k(r10b) * c(sH2O) * c(sOH) 
    w(r11b) = k(r11b) * c(sH2) * c(sHO2) 
    w(r12b) = k(r12b) * c(sHO2) * c(sOH) 
    w(r13b) = k(r13b) * c(sH2O) * c(sHO2) 
    w(r14b) = k(r14b) * c(sH2O) * c(sHO2) 
    w(r15b) = k(r15b) * c(sOH)**2.0_pr 
    w(r16b) = k(r16b) * c(sH2) * c(sO2) 
    w(r17b) = k(r17b) * c(sO2) * c(sOH) 
    w(r18b) = k(r18b) * c(sH2O) * c(sO2) 
    w(r19b) = k(r19b) * c(sH2O) * c(sO2) 
    w(r20b) = k(r20b) * cqss(sqssH2O2) * c(sO2) 
    w(r21b) = k(r21b) * cqss(sqssH2O2) * c(sO2) 
    w(r22b) = k(r22b) * c(sHO2) 
    w(r23b) = k(r23b) * c(sCO2) 
    w(r24b) = k(r24b) * c(sCO2) * c(sH) 
    w(r25b) = k(r25b) * c(sCO2) * c(sH) 
    w(r26b) = k(r26b) * c(sCO2) * c(sOH) 
    w(r27b) = k(r27b) * c(sCO2) * c(sO) 
    w(r28b) = k(r28b) * c(sCH4) 
    w(r29b) = k(r29b) * c(sCH3) * c(sH2) 
    w(r30b) = k(r30b) * c(sCH3) * c(sOH) 
    w(r31b) = k(r31b) * c(sCH3) * c(sH2O) 
    w(r32b) = k(r32b) * c(sCH3) * cqss(sqssH2O2) 
    w(r33b) = k(r33b) * c(sCH4) * c(sO2) 
    w(r34b) = k(r34b) * c(sCH3)**2.0_pr 
    w(r36b) = k(r36b) * c(sCO) * c(sH2O) 
    w(r37b) = k(r37b) * c(sCO) * c(sH2) 
    w(r38b) = k(r38b) * c(sH) * cqss(sqssHCO) 
    w(r39b) = k(r39b) * c(sCH3) * c(sH) 
    w(r40b) = k(r40b) * c(sCH2O) * c(sH) 
    w(r41b) = k(r41b) * c(sCH2O) * c(sCO) 
    w(r42b) = k(r42b) * c(sCH3) 
    w(r43b) = k(r43b) * cqss(sqssHCO) * c(sOH) 
    w(r46b) = k(r46b) * cqss(sqssCH3O) * c(sO) 
    w(r47b) = k(r47b) * c(sCH2O) * c(sOH) 
    w(r48b) = k(r48b) * c(sCH2O) * c(sH) 
    w(r49b) = k(r49b) * cqss(sqssCH2GL1G) * c(sH2O) 
    w(r50b) = k(r50b) * c(sCH2O) * c(sH2) 
    w(r51b) = k(r51b) * cqss(sqssCH3O) * c(sH) 
    w(r52b) = k(r52b) * cqss(sqssCH2GL1G) * c(sH2O) 
    w(r53b) = k(r53b) * cqss(sqssCH3O) * c(sOH) 
    w(r54b) = k(r54b) * c(sCH2O) * c(sHO2) 
    w(r55b) = k(r55b) * c(sCH2O) * c(sH2) 
    w(r56b) = k(r56b) * c(sCH2O) * cqss(sqssH2O2) 
    w(r57b) = k(r57b) * c(sCH2O) * c(sCH4) 
    w(r58b) = k(r58b) * c(sCH2O) 
    w(r59b) = k(r59b) * c(sCH2O) 
    w(r60b) = k(r60b) * cqss(sqssHCO) * c(sHO2) 
    w(r61b) = k(r61b) * cqss(sqssHCO) * c(sOH) 
    w(r62b) = k(r62b) * c(sH2) * cqss(sqssHCO) 
    w(r63b) = k(r63b) * c(sH2O) * cqss(sqssHCO) 
    w(r64b) = k(r64b) * c(sCH4) * cqss(sqssHCO) 
    w(r65b) = k(r65b) * c(sCO) * c(sH) * m(mM65)
    w(r66b) = k(r66b) * c(sCO) * c(sHO2) 
    w(r67b) = k(r67b) * c(sCO) * c(sOH) 
    w(r68b) = k(r68b) * c(sCO) * c(sH2) 
    w(r69b) = k(r69b) * c(sCO) * c(sH2O) 
    w(r70b) = k(r70b) * c(sCH4) * c(sCO) 
    w(r71b) = k(r71b) * c(sCO2) * c(sH) 
    w(r73b) = k(r73b) * c(sCH2O) * c(sH) 
    w(r74b) = k(r74b) * c(sC2H6) 
    w(r75b) = k(r75b) * c(sC2H6) 
    w(r76b) = k(r76b) * cqss(sqssC2H5) * c(sHO2) 
    w(r77b) = k(r77b) * cqss(sqssC2H5) * c(sOH) 
    w(r78b) = k(r78b) * cqss(sqssC2H5) * c(sH2) 
    w(r79b) = k(r79b) * cqss(sqssC2H5) * c(sH2O) 
    w(r80b) = k(r80b) * cqss(sqssC2H5) * c(sCH3) 
    w(r81b) = k(r81b) * cqss(sqssC2H5) * c(sCH4) 
    w(r82b) = k(r82b) * cqss(sqssC2H5) 
    w(r83b) = k(r83b) * c(sC2H4) * c(sH2) 
    w(r84b) = k(r84b) * c(sC2H4) * c(sCH4) 
    w(r85b) = k(r85b) * cqss(sqssC2H5) * c(sH) 
    w(r86b) = k(r86b) * c(sC2H4) * c(sHO2) 
    w(r87b) = k(r87b) * c(sC2H4) 
    w(r88b) = k(r88b) * c(sC2H2) * c(sH2) * m(mM88)
    w(r89b) = k(r89b) * cqss(sqssC2H3) * c(sHO2) 
    w(r90b) = k(r90b) * cqss(sqssC2H3) * c(sH2) 
    w(r91b) = k(r91b) * cqss(sqssC2H3) * c(sH2O) 
    w(r92b) = k(r92b) * cqss(sqssC2H3) * c(sCH4) 
    w(r93b) = k(r93b) * cqss(sqssC2H3) * c(sCH4) 
    w(r94b) = k(r94b) * c(sCH3) * cqss(sqssHCO) 
    w(r95b) = k(r95b) * c(sC2H4) * c(sH) 
    w(r96b) = k(r96b) * c(sCH2O) * c(sCH3) 
    w(r97b) = k(r97b) * cqss(sqssC2H3) 
    w(r98b) = k(r98b) * c(sC2H2) * c(sHO2) 
    w(r99b) = k(r99b) * c(sC2H2) * c(sHO2) 
    w(r100b) = k(r100b) * c(sCH2O) * cqss(sqssHCO) 
    w(r101b) = k(r101b) * c(sCH2O) * cqss(sqssHCO) 
    w(r104b) = k(r104b) * cqss(sqssCH3O) * c(sCO) 
    w(r105b) = k(r105b) * cqss(sqssCH3O) * c(sCO) 
    w(r106b) = k(r106b) * c(sCH3) * c(sCO2) 
    w(r107b) = k(r107b) * c(sCH3) * c(sCO2) 
    w(r108b) = k(r108b) * c(sC2H2) * c(sH2) 
    w(r109b) = k(r109b) * c(sC2H2) * c(sH2O) 
    w(r110b) = k(r110b) * c(sC2H2) * c(sCH4) 
    w(r111b) = k(r111b) * cqss(sqssCH2GL1G) * c(sCO) 
    w(r112b) = k(r112b) * c(sH) * cqss(sqssHCCO) 
    w(r113b) = k(r113b) * cqss(sqssC2H3) * c(sCO) 
    w(r114b) = k(r114b) * c(sCH3) * c(sCO) 
    w(r117b) = k(r117b) * cqss(sqssCH2GL1G) * c(sCO) 
    w(r120b) = k(r120b) * cqss(sqssC2H3) * c(sCH3) 
    w(r121b) = k(r121b) * cqss(sqssC2H3) * c(sCH3) 
    w(r122b) = k(r122b) * c(sC2H4) * cqss(sqssHCO) 
    w(r123b) = k(r123b) * c(sCO) * c(sH) * cqss(sqssHCO) 
    w(r124b) = k(r124b) * c(sCO2) * cqss(sqssHCO) 
    w(r125b) = k(r125b) * cqss(sqssHCCO) * c(sOH) 
    w(r126b) = k(r126b) * c(sHO2) * m(mM126)
    w(r130b) = k(r130b) * c(sCO) * c(sH2) 
    w(r131b) = k(r131b) * c(sCH2O) * c(sH) 
    w(r132b) = k(r132b) * c(sCH2O) * c(sCO) 
    w(r133b) = k(r133b) * c(sCO) * c(sH) 
    w(r134b) = k(r134b) * c(sCH3)**2.0_pr 
    w(r136b) = k(r136b) * c(sC2H4) * c(sH2) 
    w(r140b) = k(r140b) * c(sCH3) * c(sCO2) 
    w(r141b) = k(r141b) * c(sCH3) * c(sCO2) 
    w(r147b) = k(r147b) * c(sCO) * cqss(sqssH2O2) 
  
    return
  end subroutine get_reaction_rates
  
  ! ----------------------------------------------- !
  ! Evaluate production rates                       !
  ! ----------------------------------------------- !
  subroutine get_production_rates(cdot,w)
    implicit none

    real(pr), dimension(nspec) :: cdot
    real(pr), dimension(nreac + nreac_reverse) :: w

    cdot(sN2) = 0.0_pr 

    cdot(sH2) = 0.0_pr &
         - w(r1f) &
         + w(r1b) &
         - w(r2f) &
         + w(r2b) &
         - w(r3f) &
         + w(r3b) &
         + w(r11f) &
         - w(r11b) &
         + w(r16f) &
         - w(r16b) &
         + w(r29f) &
         - w(r29b) &
         + w(r37f) &
         - w(r37b) &
         - w(r39f) &
         + w(r39b) &
         + w(r50f) &
         - w(r50b) &
         + w(r55f) &
         - w(r55b) &
         - w(r59f) &
         + w(r59b) &
         + w(r62f) &
         - w(r62b) &
         + w(r68f) &
         - w(r68b) &
         + w(r78f) &
         - w(r78b) &
         + w(r83f) &
         - w(r83b) &
         + w(r88f) &
         - w(r88b) &
         + w(r90f) &
         - w(r90b) &
         + w(r108f) &
         - w(r108b) &
         + w(r115f) &
         + w(r130f) &
         - w(r130b) &
         + w(r135f) &
         + w(r136f) &
         - w(r136b) &
         + w(r138f) 

    cdot(sH) = 0.0_pr &
         + 2.0_pr * w(r1f) &
         - 2.0_pr * w(r1b) &
         + w(r2f) &
         - w(r2b) &
         + w(r3f) &
         - w(r3b) &
         - w(r5f) &
         + w(r5b) &
         - w(r6f) &
         + w(r6b) &
         - w(r8f) &
         + w(r8b) &
         - w(r10f) &
         + w(r10b) &
         - w(r11f) &
         + w(r11b) &
         - w(r15f) &
         + w(r15b) &
         - w(r16f) &
         + w(r16b) &
         - w(r22f) &
         + w(r22b) &
         + w(r24f) &
         - w(r24b) &
         + w(r25f) &
         - w(r25b) &
         - w(r28f) &
         + w(r28b) &
         - w(r29f) &
         + w(r29b) &
         + w(r35f) &
         + w(r38f) &
         - w(r38b) &
         + w(r39f) &
         - w(r39b) &
         + w(r40f) &
         - w(r40b) &
         - w(r42f) &
         + w(r42b) &
         + 2.0_pr * w(r44f) &
         + 2.0_pr * w(r45f) &
         + w(r48f) &
         - w(r48b) &
         + w(r51f) &
         - w(r51b) &
         - w(r55f) &
         + w(r55b) &
         - w(r58f) &
         + w(r58b) &
         - w(r62f) &
         + w(r62b) &
         + w(r65f) &
         - w(r65b) &
         - w(r68f) &
         + w(r68b) &
         + w(r71f) &
         - w(r71b) &
         + w(r72f) &
         + w(r73f) &
         - w(r73b) &
         - w(r75f) &
         + w(r75b) &
         - w(r78f) &
         + w(r78b) &
         - w(r82f) &
         + w(r82b) &
         - w(r83f) &
         + w(r83b) &
         + w(r85f) &
         - w(r85b) &
         - w(r87f) &
         + w(r87b) &
         - w(r90f) &
         + w(r90b) &
         + w(r95f) &
         - w(r95b) &
         - w(r97f) &
         + w(r97b) &
         + w(r102f) &
         + w(r103f) &
         - w(r108f) &
         + w(r108b) &
         + w(r112f) &
         - w(r112b) &
         + w(r116f) &
         - w(r117f) &
         + w(r117b) &
         + w(r119f) &
         + w(r123f) &
         - w(r123b) &
         + w(r131f) &
         - w(r131b) &
         + 2.0_pr * w(r133f) &
         - 2.0_pr * w(r133b) &
         + 2.0_pr * w(r137f) &
         + w(r138f) 

    cdot(sO2) = 0.0_pr &
         + w(r4f) &
         - w(r4b) &
         - w(r5f) &
         + w(r5b) &
         + w(r16f) &
         - w(r16b) &
         + w(r17f) &
         - w(r17b) &
         + w(r18f) &
         - w(r18b) &
         + w(r19f) &
         - w(r19b) &
         + w(r20f) &
         - w(r20b) &
         + w(r21f) &
         - w(r21b) &
         - w(r22f) &
         + w(r22b) &
         - w(r27f) &
         + w(r27b) &
         + w(r33f) &
         - w(r33b) &
         - w(r35f) &
         - w(r36f) &
         + w(r36b) &
         - w(r43f) &
         + w(r43b) &
         - w(r44f) &
         - w(r46f) &
         + w(r46b) &
         - w(r47f) &
         + w(r47b) &
         - w(r54f) &
         + w(r54b) &
         - w(r60f) &
         + w(r60b) &
         - w(r66f) &
         + w(r66b) &
         - w(r76f) &
         + w(r76b) &
         - w(r86f) &
         + w(r86b) &
         - w(r89f) &
         + w(r89b) &
         - w(r98f) &
         + w(r98b) &
         - w(r99f) &
         + w(r99b) &
         - w(r100f) &
         + w(r100b) &
         - w(r101f) &
         + w(r101b) &
         - w(r102f) &
         - w(r103f) &
         - w(r104f) &
         + w(r104b) &
         - w(r105f) &
         + w(r105b) &
         - w(r106f) &
         + w(r106b) &
         - w(r107f) &
         + w(r107b) &
         - w(r118f) &
         - w(r119f) &
         - w(r124f) &
         + w(r124b) &
         - w(r125f) &
         + w(r125b) &
         - w(r127f) &
         - w(r128f) &
         - w(r142f) &
         - w(r143f) &
         - w(r144f) &
         - w(r145f) 

    cdot(sO) = 0.0_pr &
         - w(r2f) &
         + w(r2b) &
         -2.0_pr * w(r4f) &
         + 2.0_pr * w(r4b) &
         + w(r5f) &
         - w(r5b) &
         - w(r7f) &
         + w(r7b) &
         - w(r8f) &
         + w(r8b) &
         - w(r12f) &
         + w(r12b) &
         - w(r17f) &
         + w(r17b) &
         - w(r23f) &
         + w(r23b) &
         + w(r27f) &
         - w(r27b) &
         - w(r30f) &
         + w(r30b) &
         - w(r37f) &
         + w(r37b) &
         - w(r38f) &
         + w(r38b) &
         - w(r45f) &
         + w(r46f) &
         - w(r46b) &
         - w(r48f) &
         + w(r48b) &
         - w(r61f) &
         + w(r61b) &
         - w(r67f) &
         + w(r67b) &
         - w(r71f) &
         + w(r71b) &
         - w(r77f) &
         + w(r77b) &
         - w(r94f) &
         + w(r94b) &
         - w(r111f) &
         + w(r111b) &
         - w(r112f) &
         + w(r112b) &
         - w(r116f) &
         - w(r126f) &
         + w(r126b) &
         + w(r128f) &
         - w(r130f) &
         + w(r130b) &
         - w(r133f) &
         + w(r133b) &
         - w(r137f) &
         - w(r146f) &
         - w(r152f) 

    cdot(sH2O) = 0.0_pr &
         + w(r3f) &
         - w(r3b) &
         + w(r6f) &
         - w(r6b) &
         - w(r7f) &
         + w(r7b) &
         + w(r10f) &
         - w(r10b) &
         + w(r13f) &
         - w(r13b) &
         + w(r14f) &
         - w(r14b) &
         + w(r18f) &
         - w(r18b) &
         + w(r19f) &
         - w(r19b) &
         + w(r31f) &
         - w(r31b) &
         + w(r36f) &
         - w(r36b) &
         + w(r49f) &
         - w(r49b) &
         + w(r52f) &
         - w(r52b) &
         + w(r63f) &
         - w(r63b) &
         + w(r69f) &
         - w(r69b) &
         + w(r79f) &
         - w(r79b) &
         + w(r91f) &
         - w(r91b) &
         + w(r109f) &
         - w(r109b) &
         + w(r148f) 

    cdot(sOH) = 0.0_pr &
         + w(r2f) &
         - w(r2b) &
         - w(r3f) &
         + w(r3b) &
         + w(r5f) &
         - w(r5b) &
         - w(r6f) &
         + w(r6b) &
         + 2.0_pr * w(r7f) &
         - 2.0_pr * w(r7b) &
         + w(r8f) &
         - w(r8b) &
         + 2.0_pr * w(r9f) &
         - 2.0_pr * w(r9b) &
         + w(r10f) &
         - w(r10b) &
         + w(r12f) &
         - w(r12b) &
         - w(r13f) &
         + w(r13b) &
         - w(r14f) &
         + w(r14b) &
         + 2.0_pr * w(r15f) &
         - 2.0_pr * w(r15b) &
         + w(r17f) &
         - w(r17b) &
         - w(r18f) &
         + w(r18b) &
         - w(r19f) &
         + w(r19b) &
         - w(r24f) &
         + w(r24b) &
         - w(r25f) &
         + w(r25b) &
         + w(r26f) &
         - w(r26b) &
         + w(r30f) &
         - w(r30b) &
         - w(r31f) &
         + w(r31b) &
         + w(r35f) &
         - w(r40f) &
         + w(r40b) &
         + w(r43f) &
         - w(r43b) &
         + w(r47f) &
         - w(r47b) &
         - w(r49f) &
         + w(r49b) &
         - w(r50f) &
         + w(r50b) &
         - w(r51f) &
         + w(r51b) &
         - w(r52f) &
         + w(r52b) &
         + w(r53f) &
         - w(r53b) &
         + w(r61f) &
         - w(r61b) &
         - w(r63f) &
         + w(r63b) &
         + w(r67f) &
         - w(r67b) &
         - w(r69f) &
         + w(r69b) &
         + w(r72f) &
         + w(r77f) &
         - w(r77b) &
         - w(r79f) &
         + w(r79b) &
         - w(r91f) &
         + w(r91b) &
         - w(r96f) &
         + w(r96b) &
         - w(r109f) &
         + w(r109b) &
         - w(r114f) &
         + w(r114b) &
         - w(r115f) &
         + w(r118f) &
         - w(r123f) &
         + w(r123b) &
         + w(r125f) &
         - w(r125b) &
         - w(r126f) &
         + w(r126b) &
         + w(r129f) &
         - w(r131f) &
         + w(r131b) &
         - w(r138f) &
         - w(r148f) &
         + w(r152f) 

    cdot(sHO2) = 0.0_pr &
         + w(r11f) &
         - w(r11b) &
         + w(r12f) &
         - w(r12b) &
         + w(r13f) &
         - w(r13b) &
         + w(r14f) &
         - w(r14b) &
         - w(r15f) &
         + w(r15b) &
         - w(r16f) &
         + w(r16b) &
         - w(r17f) &
         + w(r17b) &
         - w(r18f) &
         + w(r18b) &
         - w(r19f) &
         + w(r19b) &
         -2.0_pr * w(r20f) &
         + 2.0_pr * w(r20b) &
         -2.0_pr * w(r21f) &
         + 2.0_pr * w(r21b) &
         + w(r22f) &
         - w(r22b) &
         - w(r26f) &
         + w(r26b) &
         - w(r32f) &
         + w(r32b) &
         - w(r33f) &
         + w(r33b) &
         - w(r53f) &
         + w(r53b) &
         + w(r54f) &
         - w(r54b) &
         - w(r56f) &
         + w(r56b) &
         + w(r60f) &
         - w(r60b) &
         + w(r66f) &
         - w(r66b) &
         - w(r72f) &
         + w(r76f) &
         - w(r76b) &
         + w(r86f) &
         - w(r86b) &
         + w(r89f) &
         - w(r89b) &
         + w(r98f) &
         - w(r98b) &
         + w(r99f) &
         - w(r99b) &
         + w(r126f) &
         - w(r126b) &
         - w(r129f) &
         - w(r139f) &
         - w(r147f) &
         + w(r147b) &
         - w(r153f) 

    cdot(sCO) = 0.0_pr &
         - w(r23f) &
         + w(r23b) &
         - w(r24f) &
         + w(r24b) &
         - w(r25f) &
         + w(r25b) &
         - w(r26f) &
         + w(r26b) &
         - w(r27f) &
         + w(r27b) &
         + w(r35f) &
         + w(r36f) &
         - w(r36b) &
         + w(r37f) &
         - w(r37b) &
         + w(r41f) &
         - w(r41b) &
         + w(r45f) &
         - w(r59f) &
         + w(r59b) &
         + w(r65f) &
         - w(r65b) &
         + w(r66f) &
         - w(r66b) &
         + w(r67f) &
         - w(r67b) &
         + w(r68f) &
         - w(r68b) &
         + w(r69f) &
         - w(r69b) &
         + w(r70f) &
         - w(r70b) &
         + w(r102f) &
         + w(r103f) &
         + w(r104f) &
         - w(r104b) &
         + w(r105f) &
         - w(r105b) &
         + w(r111f) &
         - w(r111b) &
         + w(r113f) &
         - w(r113b) &
         + w(r114f) &
         - w(r114b) &
         + 2.0_pr * w(r115f) &
         + 2.0_pr * w(r116f) &
         + w(r117f) &
         - w(r117b) &
         + 2.0_pr * w(r118f) &
         + w(r119f) &
         + w(r123f) &
         - w(r123b) &
         + w(r130f) &
         - w(r130b) &
         + w(r132f) &
         - w(r132b) &
         + w(r133f) &
         - w(r133b) &
         - w(r141f) &
         + w(r141b) &
         + w(r142f) &
         + w(r147f) &
         - w(r147b) 

    cdot(sCO2) = 0.0_pr &
         + w(r23f) &
         - w(r23b) &
         + w(r24f) &
         - w(r24b) &
         + w(r25f) &
         - w(r25b) &
         + w(r26f) &
         - w(r26b) &
         + w(r27f) &
         - w(r27b) &
         - w(r41f) &
         + w(r41b) &
         + w(r44f) &
         + w(r71f) &
         - w(r71b) &
         + w(r72f) &
         + w(r106f) &
         - w(r106b) &
         + w(r107f) &
         - w(r107b) &
         + w(r119f) &
         + w(r124f) &
         - w(r124b) &
         - w(r132f) &
         + w(r132b) &
         + w(r137f) &
         + w(r138f) &
         + w(r140f) &
         - w(r140b) &
         + w(r141f) &
         - w(r141b) 

    cdot(sCH4) = 0.0_pr &
         + w(r28f) &
         - w(r28b) &
         - w(r29f) &
         + w(r29b) &
         - w(r30f) &
         + w(r30b) &
         - w(r31f) &
         + w(r31b) &
         - w(r32f) &
         + w(r32b) &
         + w(r33f) &
         - w(r33b) &
         - w(r34f) &
         + w(r34b) &
         + w(r57f) &
         - w(r57b) &
         + w(r64f) &
         - w(r64b) &
         + w(r70f) &
         - w(r70b) &
         + w(r81f) &
         - w(r81b) &
         + w(r84f) &
         - w(r84b) &
         + w(r92f) &
         - w(r92b) &
         + w(r93f) &
         - w(r93b) &
         + w(r110f) &
         - w(r110b) &
         - w(r134f) &
         + w(r134b) 

    cdot(sCH3) = 0.0_pr &
         - w(r28f) &
         + w(r28b) &
         + w(r29f) &
         - w(r29b) &
         + w(r30f) &
         - w(r30b) &
         + w(r31f) &
         - w(r31b) &
         + w(r32f) &
         - w(r32b) &
         - w(r33f) &
         + w(r33b) &
         + 2.0_pr * w(r34f) &
         - 2.0_pr * w(r34b) &
         + w(r39f) &
         - w(r39b) &
         + w(r42f) &
         - w(r42b) &
         - w(r46f) &
         + w(r46b) &
         - w(r47f) &
         + w(r47b) &
         - w(r48f) &
         + w(r48b) &
         - w(r49f) &
         + w(r49b) &
         - w(r50f) &
         + w(r50b) &
         - w(r51f) &
         + w(r51b) &
         - w(r52f) &
         + w(r52b) &
         - w(r53f) &
         + w(r53b) &
         - w(r57f) &
         + w(r57b) &
         - w(r64f) &
         + w(r64b) &
         - w(r70f) &
         + w(r70b) &
         -2.0_pr * w(r74f) &
         + 2.0_pr * w(r74b) &
         + w(r80f) &
         - w(r80b) &
         - w(r81f) &
         + w(r81b) &
         - w(r84f) &
         + w(r84b) &
         -2.0_pr * w(r85f) &
         + 2.0_pr * w(r85b) &
         - w(r92f) &
         + w(r92b) &
         - w(r93f) &
         + w(r93b) &
         + w(r94f) &
         - w(r94b) &
         - w(r95f) &
         + w(r95b) &
         + w(r96f) &
         - w(r96b) &
         + w(r106f) &
         - w(r106b) &
         + w(r107f) &
         - w(r107b) &
         - w(r110f) &
         + w(r110b) &
         + w(r114f) &
         - w(r114b) &
         + w(r120f) &
         - w(r120b) &
         + w(r121f) &
         - w(r121b) &
         + w(r128f) &
         + w(r129f) &
         + 2.0_pr * w(r134f) &
         - 2.0_pr * w(r134b) &
         -2.0_pr * w(r135f) &
         + w(r140f) &
         - w(r140b) &
         + w(r141f) &
         - w(r141b) &
         - w(r146f) 

    cdot(sCH2O) = 0.0_pr &
         + w(r40f) &
         - w(r40b) &
         + w(r41f) &
         - w(r41b) &
         + w(r47f) &
         - w(r47b) &
         + w(r48f) &
         - w(r48b) &
         + w(r50f) &
         - w(r50b) &
         + w(r54f) &
         - w(r54b) &
         + w(r55f) &
         - w(r55b) &
         + w(r56f) &
         - w(r56b) &
         + w(r57f) &
         - w(r57b) &
         + w(r58f) &
         - w(r58b) &
         + w(r59f) &
         - w(r59b) &
         - w(r60f) &
         + w(r60b) &
         - w(r61f) &
         + w(r61b) &
         - w(r62f) &
         + w(r62b) &
         - w(r63f) &
         + w(r63b) &
         - w(r64f) &
         + w(r64b) &
         + w(r73f) &
         - w(r73b) &
         + w(r96f) &
         - w(r96b) &
         + w(r100f) &
         - w(r100b) &
         + w(r101f) &
         - w(r101b) &
         + w(r102f) &
         + w(r103f) &
         - w(r122f) &
         + w(r122b) &
         + w(r127f) &
         + w(r128f) &
         + w(r129f) &
         + w(r131f) &
         - w(r131b) &
         + w(r132f) &
         - w(r132b) &
         - w(r137f) &
         - w(r138f) &
         + w(r139f) &
         - w(r140f) &
         + w(r140b) &
         + w(r142f) &
         + 2.0_pr * w(r143f) &
         + w(r148f) &
         + w(r150f) &
         - w(r154f) 

    cdot(sC2H6) = 0.0_pr &
         + w(r74f) &
         - w(r74b) &
         + w(r75f) &
         - w(r75b) &
         - w(r76f) &
         + w(r76b) &
         - w(r77f) &
         + w(r77b) &
         - w(r78f) &
         + w(r78b) &
         - w(r79f) &
         + w(r79b) &
         - w(r80f) &
         + w(r80b) &
         - w(r81f) &
         + w(r81b) &
         - w(r136f) &
         + w(r136b) &
         - w(r149f) &
         - w(r150f) &
         + w(r151f) &
         + w(r154f) 

    cdot(sC2H4) = 0.0_pr &
         - w(r82f) &
         + w(r82b) &
         + w(r83f) &
         - w(r83b) &
         + w(r84f) &
         - w(r84b) &
         + w(r86f) &
         - w(r86b) &
         + w(r87f) &
         - w(r87b) &
         - w(r88f) &
         + w(r88b) &
         - w(r89f) &
         + w(r89b) &
         - w(r90f) &
         + w(r90b) &
         - w(r91f) &
         + w(r91b) &
         - w(r92f) &
         + w(r92b) &
         - w(r93f) &
         + w(r93b) &
         - w(r94f) &
         + w(r94b) &
         + w(r95f) &
         - w(r95b) &
         - w(r96f) &
         + w(r96b) &
         - w(r120f) &
         + w(r120b) &
         - w(r121f) &
         + w(r121b) &
         + w(r122f) &
         - w(r122b) &
         + w(r135f) &
         + w(r136f) &
         - w(r136b) &
         - w(r143f) &
         - w(r145f) &
         + w(r149f) &
         - w(r151f) &
         - w(r152f) &
         - w(r153f) 

    cdot(sC2H2) = 0.0_pr &
         + w(r88f) &
         - w(r88b) &
         - w(r97f) &
         + w(r97b) &
         + w(r98f) &
         - w(r98b) &
         + w(r99f) &
         - w(r99b) &
         + w(r108f) &
         - w(r108b) &
         + w(r109f) &
         - w(r109b) &
         + w(r110f) &
         - w(r110b) &
         - w(r111f) &
         + w(r111b) &
         - w(r112f) &
         + w(r112b) &
         - w(r113f) &
         + w(r113b) &
         - w(r114f) &
         + w(r114b) &
         - w(r125f) &
         + w(r125b) &
         - w(r139f) &
         - w(r142f) &
         - w(r144f) 

  
    return
  end subroutine get_production_rates


  ! ----------------------------------------------- !
  ! Evaluation of QSS concentrations                !
  ! ----------------------------------------------- !
  subroutine get_qss(cqss,c,k,M)
    implicit none

    real(pr), dimension(nqss) :: cqss
    real(pr), dimension(nspec) :: c
    real(pr), dimension(nreac + nreac_reverse) :: k
    real(pr), dimension(nTB + nFO) :: M
    
    integer :: index

    real(pr) :: H2O2_ct
    real(pr) :: H2O2_num
    real(pr) :: H2O2_denom
    real(pr) :: H2O2_CH3O
    real(pr) :: H2O2_HCO
    real(pr) :: CH3O_ct
    real(pr) :: CH3O_num
    real(pr) :: CH3O_denom
    real(pr) :: CH3O_H2O2
    real(pr) :: CH3O_C2H5
    real(pr) :: CH3O_C2H3
    real(pr) :: HCO_ct
    real(pr) :: HCO_num
    real(pr) :: HCO_denom
    real(pr) :: HCO_H2O2
    real(pr) :: HCO_C2H5
    real(pr) :: HCO_C2H3
    real(pr) :: HCO_HCCO
    real(pr) :: HCO_CH2GL1G
    real(pr) :: C2H5_ct
    real(pr) :: C2H5_num
    real(pr) :: C2H5_denom
    real(pr) :: C2H5_HCO
    real(pr) :: C2H5_C2H3
    real(pr) :: C2H5_CH2GL1G
    real(pr) :: C2H3_ct
    real(pr) :: C2H3_num
    real(pr) :: C2H3_denom
    real(pr) :: C2H3_CH3O
    real(pr) :: C2H3_HCO
    real(pr) :: C2H3_C2H5
    real(pr) :: C2H3_CH2GL1G
    real(pr) :: HCCO_ct
    real(pr) :: HCCO_num
    real(pr) :: HCCO_denom
    real(pr) :: HCCO_HCO
    real(pr) :: HCCO_CH2GL1G
    real(pr) :: CH2GL1G_ct
    real(pr) :: CH2GL1G_num
    real(pr) :: CH2GL1G_denom
    real(pr) :: CH2GL1G_HCO
    real(pr) :: CH2GL1G_C2H5
    real(pr) :: CH2GL1G_C2H3
    real(pr) :: CH2GL1G_HCCO
  
    real(pr) :: a_h_a
    real(pr) :: a_i_a
    real(pr) :: a_o_a
    real(pr) :: a_p_a
    real(pr) :: a_v_a
    real(pr) :: a_ac_a
    real(pr) :: a_aj_a
    real(pr) :: a_aq_a
    real(pr) :: a_ar_a
    real(pr) :: a_q_b
    real(pr) :: a_r_b
    real(pr) :: a_s_b
    real(pr) :: a_t_b
    real(pr) :: a_x_b
    real(pr) :: a_y_b
    real(pr) :: a_z_b
    real(pr) :: a_aa_b
    real(pr) :: a_ae_b
    real(pr) :: a_af_b
    real(pr) :: a_ag_b
    real(pr) :: a_ah_b
    real(pr) :: a_al_b
    real(pr) :: a_am_b
    real(pr) :: a_an_b
    real(pr) :: a_ao_b
    real(pr) :: a_as_b
    real(pr) :: a_at_b
    real(pr) :: a_au_b
    real(pr) :: a_av_b
    real(pr) :: a_x_c
    real(pr) :: a_aa_c
    real(pr) :: a_ae_c
    real(pr) :: a_ah_c
    real(pr) :: a_al_c
    real(pr) :: a_ao_c
    real(pr) :: a_as_c
    real(pr) :: a_av_c
    real(pr) :: a_af_d
    real(pr) :: a_ah_d
    real(pr) :: a_am_d
    real(pr) :: a_ao_d
    real(pr) :: a_at_d
    real(pr) :: a_av_d
    real(pr) :: a_an_e
    real(pr) :: a_ao_e
    real(pr) :: a_au_e
    real(pr) :: a_av_e
    real(pr) :: A_A_A
    real(pr) :: A_B_A
    real(pr) :: A_C_A
    real(pr) :: A_D_A
    real(pr) :: A_E_A
    real(pr) :: A_F_A
    real(pr) :: A_B_B
    real(pr) :: A_C_B
    real(pr) :: A_D_B
    real(pr) :: A_E_B
    real(pr) :: A_F_B
    real(pr) :: A_C_C
    real(pr) :: A_D_C
    real(pr) :: A_E_C
    real(pr) :: A_F_C
    real(pr) :: A_D_D
    real(pr) :: A_E_D
    real(pr) :: A_F_D
    real(pr) :: A_E_E
    real(pr) :: A_F_E
    real(pr) :: A_F_F

    C2H3_denom = tiny(1.0_pr) + ( 0.0_pr &
             + k(r87f)* c(sH) &
             + k(r98f)* c(sO2) &
             + k(r99f)* c(sO2) &
             + k(r100f)* c(sO2) &
             + k(r101f)* c(sO2) &
             + k(r102f)* c(sO2) &
             + k(r103f)* c(sO2) &
             + k(r104f)* c(sO2) &
             + k(r105f)* c(sO2) &
             + k(r106f)* c(sO2) &
             + k(r107f)* c(sO2) &
             + k(r108f)* c(sH) &
             + k(r109f)* c(sOH) &
             + k(r110f)* c(sCH3) &
             + k(r122f)* c(sCH2O) &
             + k(r149f)* c(sC2H6) &
             + k(r89b)* c(sHO2) &
             + k(r90b)* c(sH2) &
             + k(r91b)* c(sH2O) &
             + k(r92b)* c(sCH4) &
             + k(r93b)* c(sCH4) &
             + k(r97b)&
             + k(r113b)* c(sCO) &
             + k(r120b)* c(sCH3) &
             + k(r121b)* c(sCH3)   )

    C2H3_num = ( 0.0_pr &
             + k(r89f)* c(sC2H4) * c(sO2) &
             + k(r90f)* c(sC2H4) * c(sH) &
             + k(r91f)* c(sC2H4) * c(sOH) &
             + k(r92f)* c(sC2H4) * c(sCH3) &
             + k(r93f)* c(sC2H4) * c(sCH3) &
             + k(r97f)* c(sC2H2) * c(sH) &
             + k(r152f)* c(sC2H4) * c(sO) &
             + k(r153f)* c(sC2H4) * c(sHO2) &
             + k(r87b)* c(sC2H4) &
             + k(r98b)* c(sC2H2) * c(sHO2) &
             + k(r99b)* c(sC2H2) * c(sHO2) &
             + k(r106b)* c(sCH3) * c(sCO2) &
             + k(r107b)* c(sCH3) * c(sCO2) &
             + k(r108b)* c(sC2H2) * c(sH2) &
             + k(r109b)* c(sC2H2) * c(sH2O) &
             + k(r110b)* c(sC2H2) * c(sCH4)   )

    C2H3_ct = C2H3_num / C2H3_denom

    C2H3_CH3O = - ( 0.0_pr &
          + k(r104b) * c(sCO) &
          + k(r105b) * c(sCO)  ) / C2H3_denom

    C2H3_HCO = - ( 0.0_pr &
          + k(r113f) * c(sC2H2) &
          + k(r100b) * c(sCH2O) &
          + k(r101b) * c(sCH2O) &
          + k(r122b) * c(sC2H4)  ) / C2H3_denom

    C2H3_C2H5 = - ( 0.0_pr &
          + k(r151f) * c(sC2H4)  ) / C2H3_denom

    C2H3_CH2GL1G = - ( 0.0_pr &
          + k(r120f) * c(sC2H4) &
          + k(r121f) * c(sC2H4)  ) / C2H3_denom

    HCCO_denom = tiny(1.0_pr) + ( 0.0_pr &
             + k(r115f)* c(sOH) &
             + k(r116f)* c(sO) &
             + k(r117f)* c(sH) &
             + k(r118f)* c(sO2) &
             + k(r119f)* c(sO2) &
             + k(r123f)* c(sOH) &
             + k(r124f)* c(sO2) &
             + k(r112b)* c(sH) &
             + k(r125b)* c(sOH)   )

    HCCO_num = ( 0.0_pr &
             + k(r112f)* c(sC2H2) * c(sO) &
             + k(r125f)* c(sC2H2) * c(sO2)   )

    HCCO_ct = HCCO_num / HCCO_denom

    HCCO_HCO = - ( 0.0_pr &
          + k(r123b) * c(sCO) * c(sH) &
          + k(r124b) * c(sCO2)  ) / HCCO_denom

    HCCO_CH2GL1G = - ( 0.0_pr &
          + k(r117b) * c(sCO)  ) / HCCO_denom

    CH2GL1G_denom = tiny(1.0_pr) + ( 0.0_pr &
             + k(r34f)* c(sCH4) &
             + k(r35f)* c(sO2) &
             + k(r36f)* c(sO2) &
             + k(r37f)* c(sO) &
             + k(r38f)* c(sO) &
             + k(r39f)* c(sH2) &
             + k(r40f)* c(sOH) &
             + k(r41f)* c(sCO2) &
             + k(r42f)* c(sH) &
             + k(r43f)* c(sO2) &
             + k(r44f)* c(sO2) &
             + k(r45f)* c(sO) &
             + k(r80f)* c(sC2H6) &
             + k(r95f)* c(sCH3) &
             + k(r120f)* c(sC2H4) &
             + k(r121f)* c(sC2H4) &
             + k(r130f)* c(sO) &
             + k(r131f)* c(sOH) &
             + k(r132f)* c(sCO2) &
             + k(r133f)* c(sO) &
             + k(r134f)* c(sCH4) &
             + k(r49b)* c(sH2O) &
             + k(r52b)* c(sH2O) &
             + k(r111b)* c(sCO) &
             + k(r117b)* c(sCO)   )

    CH2GL1G_num = ( 0.0_pr &
             + k(r49f)* c(sCH3) * c(sOH) &
             + k(r52f)* c(sCH3) * c(sOH) &
             + k(r111f)* c(sC2H2) * c(sO) &
             + k(r34b) *c(sCH3)** 2.0_pr&
             + k(r36b)* c(sCO) * c(sH2O) &
             + k(r37b)* c(sCO) * c(sH2) &
             + k(r39b)* c(sCH3) * c(sH) &
             + k(r40b)* c(sCH2O) * c(sH) &
             + k(r41b)* c(sCH2O) * c(sCO) &
             + k(r42b)* c(sCH3) &
             + k(r95b)* c(sC2H4) * c(sH) &
             + k(r130b)* c(sCO) * c(sH2) &
             + k(r131b)* c(sCH2O) * c(sH) &
             + k(r132b)* c(sCH2O) * c(sCO) &
             + k(r133b)* c(sCO)  *c(sH)** 2.0_pr&
             + k(r134b) *c(sCH3)** 2.0_pr  )

    CH2GL1G_ct = CH2GL1G_num / CH2GL1G_denom

    CH2GL1G_HCO = - ( 0.0_pr &
          + k(r38b) * c(sH) &
          + k(r43b) * c(sOH)  ) / CH2GL1G_denom

    CH2GL1G_C2H5 = - ( 0.0_pr &
          + k(r80b) * c(sCH3)  ) / CH2GL1G_denom

    CH2GL1G_C2H3 = - ( 0.0_pr &
          + k(r120b) * c(sCH3) &
          + k(r121b) * c(sCH3)  ) / CH2GL1G_denom

    CH2GL1G_HCCO = - ( 0.0_pr &
          + k(r117f) * c(sH)  ) / CH2GL1G_denom

    C2H5_denom = tiny(1.0_pr) + ( 0.0_pr &
             + k(r75f)* c(sH) &
             + k(r83f)* c(sH) &
             + k(r84f)* c(sCH3) &
             + k(r86f)* c(sO2) &
             + k(r127f)* c(sO2) &
             + k(r128f)* c(sO2) &
             + k(r129f)* c(sHO2) &
             + k(r151f)* c(sC2H4) &
             + k(r154f)* c(sCH2O) &
             + k(r76b)* c(sHO2) &
             + k(r77b)* c(sOH) &
             + k(r78b)* c(sH2) &
             + k(r79b)* c(sH2O) &
             + k(r80b)* c(sCH3) &
             + k(r81b)* c(sCH4) &
             + k(r82b)&
             + k(r85b)* c(sH)   )

    C2H5_num = ( 0.0_pr &
             + k(r76f)* c(sC2H6) * c(sO2) &
             + k(r77f)* c(sC2H6) * c(sO) &
             + k(r78f)* c(sC2H6) * c(sH) &
             + k(r79f)* c(sC2H6) * c(sOH) &
             + k(r81f)* c(sC2H6) * c(sCH3) &
             + k(r82f)* c(sC2H4) * c(sH) &
             + k(r85f) *c(sCH3)** 2.0_pr&
             + k(r75b)* c(sC2H6) &
             + k(r83b)* c(sC2H4) * c(sH2) &
             + k(r84b)* c(sC2H4) * c(sCH4) &
             + k(r86b)* c(sC2H4) * c(sHO2)   )

    C2H5_ct = C2H5_num / C2H5_denom

    C2H5_HCO = - ( 0.0_pr &
          + k(r150f) * c(sC2H6)  ) / C2H5_denom

    C2H5_C2H3 = - ( 0.0_pr &
          + k(r149f) * c(sC2H6)  ) / C2H5_denom

    C2H5_CH2GL1G = - ( 0.0_pr &
          + k(r80f) * c(sC2H6)  ) / C2H5_denom

    CH3O_denom = tiny(1.0_pr) + ( 0.0_pr &
             + k(r54f)* c(sO2) &
             + k(r55f)* c(sH) &
             + k(r56f)* c(sHO2) &
             + k(r57f)* c(sCH3) &
             + k(r73f)&
             + k(r141f)* c(sCO) &
             + k(r148f)* c(sOH) &
             + k(r46b)* c(sO) &
             + k(r51b)* c(sH) &
             + k(r53b)* c(sOH) &
             + k(r104b)* c(sCO) &
             + k(r105b)* c(sCO)   )

    CH3O_num = ( 0.0_pr &
             + k(r46f)* c(sCH3) * c(sO2) &
             + k(r51f)* c(sCH3) * c(sOH) &
             + k(r53f)* c(sCH3) * c(sHO2) &
             + k(r145f)* c(sC2H4) * c(sO2) &
             + k(r146f)* c(sCH3) * c(sO) * m(mM146) &
             + k(r54b)* c(sCH2O) * c(sHO2) &
             + k(r55b)* c(sCH2O) * c(sH2) &
             + k(r57b)* c(sCH2O) * c(sCH4) &
             + k(r73b)* c(sCH2O) * c(sH) &
             + k(r141b)* c(sCH3) * c(sCO2)   )

    CH3O_ct = CH3O_num / CH3O_denom

    CH3O_H2O2 = - ( 0.0_pr &
          + k(r56b) * c(sCH2O)  ) / CH3O_denom

    CH3O_C2H5 = - ( 0.0_pr &
          + k(r127f) * c(sO2)  ) / CH3O_denom

    CH3O_C2H3 = - ( 0.0_pr &
          + k(r104f) * c(sO2) &
          + k(r105f) * c(sO2)  ) / CH3O_denom

    HCO_denom = tiny(1.0_pr) + ( 0.0_pr &
             + k(r58f)* c(sH) &
             + k(r65f)* m(mM65) &
             + k(r66f)* c(sO2) &
             + k(r67f)* c(sO) &
             + k(r68f)* c(sH) &
             + k(r69f)* c(sOH) &
             + k(r70f)* c(sCH3) &
             + k(r71f)* c(sO) &
             + k(r72f)* c(sHO2) &
             + k(r113f)* c(sC2H2) &
             + k(r140f)* c(sCH2O) &
             + k(r147f)* c(sHO2) &
             + k(r150f)* c(sC2H6) &
             + k(r38b)* c(sH) &
             + k(r43b)* c(sOH) &
             + k(r60b)* c(sHO2) &
             + k(r61b)* c(sOH) &
             + k(r62b)* c(sH2) &
             + k(r63b)* c(sH2O) &
             + k(r64b)* c(sCH4) &
             + k(r94b)* c(sCH3) &
             + k(r100b)* c(sCH2O) &
             + k(r101b)* c(sCH2O) &
             + k(r122b)* c(sC2H4) &
             + k(r123b)* c(sCO) * c(sH) &
             + k(r124b)* c(sCO2)   )

    HCO_num = ( 0.0_pr &
             + k(r60f)* c(sCH2O) * c(sO2) &
             + k(r61f)* c(sCH2O) * c(sO) &
             + k(r62f)* c(sCH2O) * c(sH) &
             + k(r63f)* c(sCH2O) * c(sOH) &
             + k(r64f)* c(sCH2O) * c(sCH3) &
             + k(r94f)* c(sC2H4) * c(sO) &
             + k(r139f)* c(sC2H2) * c(sHO2) &
     +2.0_pr * k(r144f)* c(sC2H2) * c(sO2) &
             + k(r145f)* c(sC2H4) * c(sO2) &
             + k(r58b)* c(sCH2O) &
             + k(r65b)* c(sCO) * c(sH) * m(mM65) &
             + k(r66b)* c(sCO) * c(sHO2) &
             + k(r67b)* c(sCO) * c(sOH) &
             + k(r68b)* c(sCO) * c(sH2) &
             + k(r69b)* c(sCO) * c(sH2O) &
             + k(r70b)* c(sCH4) * c(sCO) &
             + k(r71b)* c(sCO2) * c(sH) &
             + k(r140b)* c(sCH3) * c(sCO2)   )

    HCO_ct = HCO_num / HCO_denom

    HCO_H2O2 = - ( 0.0_pr &
          + k(r147b) * c(sCO)  ) / HCO_denom

    HCO_C2H5 = - ( 0.0_pr &
          + k(r154f) * c(sCH2O)  ) / HCO_denom

    HCO_C2H3 = - ( 0.0_pr &
          + k(r100f) * c(sO2) &
          + k(r101f) * c(sO2) &
          + k(r122f) * c(sCH2O) &
          + k(r113b) * c(sCO)  ) / HCO_denom

    HCO_HCCO = - ( 0.0_pr &
          + k(r123f) * c(sOH) &
          + k(r124f) * c(sO2)  ) / HCO_denom

    HCO_CH2GL1G = - ( 0.0_pr &
          + k(r38f) * c(sO) &
          + k(r43f) * c(sO2)  ) / HCO_denom

    H2O2_denom = tiny(1.0_pr) + ( 0.0_pr &
             + k(r9f)&
             + k(r10f)* c(sH) &
             + k(r11f)* c(sH) &
             + k(r12f)* c(sO) &
             + k(r13f)* c(sOH) &
             + k(r14f)* c(sOH) &
             + k(r20b)* c(sO2) &
             + k(r21b)* c(sO2) &
             + k(r32b)* c(sCH3) &
             + k(r56b)* c(sCH2O) &
             + k(r147b)* c(sCO)   )

    H2O2_num = ( 0.0_pr &
             + k(r20f) *c(sHO2)** 2.0_pr&
             + k(r21f) *c(sHO2)** 2.0_pr&
             + k(r32f)* c(sCH4) * c(sHO2) &
             + k(r153f)* c(sC2H4) * c(sHO2) &
             + k(r9b) *c(sOH)** 2.0_pr&
             + k(r10b)* c(sH2O) * c(sOH) &
             + k(r11b)* c(sH2) * c(sHO2) &
             + k(r12b)* c(sHO2) * c(sOH) &
             + k(r13b)* c(sH2O) * c(sHO2) &
             + k(r14b)* c(sH2O) * c(sHO2)   )

    H2O2_ct = H2O2_num / H2O2_denom

    H2O2_CH3O = - ( 0.0_pr &
          + k(r56f) * c(sHO2)  ) / H2O2_denom

    H2O2_HCO = - ( 0.0_pr &
          + k(r147f) * c(sHO2)  ) / H2O2_denom

    a_h_a =  (1.0_pr) - (H2O2_HCO) * (HCO_H2O2)
    a_i_a =  - (H2O2_CH3O) * (HCO_H2O2)
    a_o_a =  - (H2O2_HCO) * (CH3O_H2O2)
    a_p_a =  (1.0_pr) - (H2O2_CH3O) * (CH3O_H2O2)
    a_v_a = C2H5_HCO
    a_ac_a = CH2GL1G_HCO
    a_aj_a = HCCO_HCO
    a_aq_a = C2H3_HCO
    a_ar_a = C2H3_CH3O
    a_q_b =  (CH3O_C2H5) - (HCO_C2H5) * (a_o_a) / (a_h_a)
    a_r_b =  - (HCO_CH2GL1G) * (a_o_a) / (a_h_a)
    a_s_b =  - (HCO_HCCO) * (a_o_a) / (a_h_a)
    a_t_b =  (CH3O_C2H3) - (HCO_C2H3) * (a_o_a) / (a_h_a)
    a_x_b =  (1.0_pr) - (HCO_C2H5) * (a_v_a) / (a_h_a)
    a_y_b =  (C2H5_CH2GL1G) - (HCO_CH2GL1G) * (a_v_a) / (a_h_a)
    a_z_b =  - (HCO_HCCO) * (a_v_a) / (a_h_a)
    a_aa_b =  (C2H5_C2H3) - (HCO_C2H3) * (a_v_a) / (a_h_a)
    a_ae_b =  (CH2GL1G_C2H5) - (HCO_C2H5) * (a_ac_a) / (a_h_a)
    a_af_b =  (1.0_pr) - (HCO_CH2GL1G) * (a_ac_a) / (a_h_a)
    a_ag_b =  (CH2GL1G_HCCO) - (HCO_HCCO) * (a_ac_a) / (a_h_a)
    a_ah_b =  (CH2GL1G_C2H3) - (HCO_C2H3) * (a_ac_a) / (a_h_a)
    a_al_b =  - (HCO_C2H5) * (a_aj_a) / (a_h_a)
    a_am_b =  (HCCO_CH2GL1G) - (HCO_CH2GL1G) * (a_aj_a) / (a_h_a)
    a_an_b =  (1.0_pr) - (HCO_HCCO) * (a_aj_a) / (a_h_a)
    a_ao_b =  - (HCO_C2H3) * (a_aj_a) / (a_h_a)
    a_as_b =  (C2H3_C2H5) - (HCO_C2H5) * (a_aq_a) / (a_h_a)
    a_at_b =  (C2H3_CH2GL1G) - (HCO_CH2GL1G) * (a_aq_a) / (a_h_a)
    a_au_b =  - (HCO_HCCO) * (a_aq_a) / (a_h_a)
    a_av_b =  (1.0_pr) - (HCO_C2H3) * (a_aq_a) / (a_h_a)
    a_x_c = a_x_b
    a_aa_c = a_aa_b
    a_ae_c = a_ae_b
    a_ah_c = a_ah_b
    a_al_c = a_al_b
    a_ao_c = a_ao_b
    a_as_c =  (a_as_b) - (a_q_b) * (a_ar_a) / (a_p_a)
    a_av_c =  (a_av_b) - (a_t_b) * (a_ar_a) / (a_p_a)
    a_af_d =  (a_af_b) - (a_y_b) * (a_ae_c) / (a_x_c)
    a_ah_d =  (a_ah_c) - (a_aa_c) * (a_ae_c) / (a_x_c)
    a_am_d =  (a_am_b) - (a_y_b) * (a_al_c) / (a_x_c)
    a_ao_d =  (a_ao_c) - (a_aa_c) * (a_al_c) / (a_x_c)
    a_at_d =  (a_at_b) - (a_y_b) * (a_as_c) / (a_x_c)
    a_av_d =  (a_av_c) - (a_aa_c) * (a_as_c) / (a_x_c)
    a_an_e =  (a_an_b) - (a_ag_b) * (a_am_d) / (a_af_d)
    a_ao_e =  (a_ao_d) - (a_ah_d) * (a_am_d) / (a_af_d)
    a_au_e =  (a_au_b) - (a_ag_b) * (a_at_d) / (a_af_d)
    a_av_e =  (a_av_d) - (a_ah_d) * (a_at_d) / (a_af_d)
    A_A_A =  (HCO_ct) - (H2O2_ct) * (HCO_H2O2)
    A_B_A =  (CH3O_ct) - (H2O2_ct) * (CH3O_H2O2)
    A_C_A = C2H5_ct
    A_D_A = CH2GL1G_ct
    A_E_A = HCCO_ct
    A_F_A = C2H3_ct
    A_B_B =  (A_B_A) - (A_A_A) * (a_o_a) / (a_h_a)
    A_C_B =  (A_C_A) - (A_A_A) * (a_v_a) / (a_h_a)
    A_D_B =  (A_D_A) - (A_A_A) * (a_ac_a) / (a_h_a)
    A_E_B =  (A_E_A) - (A_A_A) * (a_aj_a) / (a_h_a)
    A_F_B =  (A_F_A) - (A_A_A) * (a_aq_a) / (a_h_a)
    A_C_C = A_C_B
    A_D_C = A_D_B
    A_E_C = A_E_B
    A_F_C =  (A_F_B) - (A_B_B) * (a_ar_a) / (a_p_a)
    A_D_D =  (A_D_C) - (A_C_C) * (a_ae_c) / (a_x_c)
    A_E_D =  (A_E_C) - (A_C_C) * (a_al_c) / (a_x_c)
    A_F_D =  (A_F_C) - (A_C_C) * (a_as_c) / (a_x_c)
    A_E_E =  (A_E_D) - (A_D_D) * (a_am_d) / (a_af_d)
    A_F_E =  (A_F_D) - (A_D_D) * (a_at_d) / (a_af_d)
    A_F_F =  (A_F_E) - (A_E_E) * (a_au_e) / (a_an_e)

    cqss(sqssC2H3) = ( A_F_F ) / ( a_av_e )  

    cqss(sqssHCCO) = (A_E_E - (a_ao_e) * cqss(sqssC2H3)) / (a_an_e)  

    cqss(sqssCH2GL1G) = (A_D_D - (a_ah_d) * cqss(sqssC2H3) - (a_ag_b) &
                 * cqss(sqssHCCO)) / (a_af_d)  

    cqss(sqssC2H5) = (A_C_C - (a_aa_c) * cqss(sqssC2H3) - (a_z_b) &
                 * cqss(sqssHCCO) - (a_y_b) * cqss(sqssCH2GL1G)) &
                 / (a_x_c)  

    cqss(sqssCH3O) = (A_B_B - (a_t_b) * cqss(sqssC2H3) - (a_s_b) &
                 * cqss(sqssHCCO) - (a_r_b) * cqss(sqssCH2GL1G) &
                 - (a_q_b) * cqss(sqssC2H5)) / (a_p_a)  

    cqss(sqssHCO) = (A_A_A - (HCO_C2H3) * cqss(sqssC2H3) - (HCO_HCCO) &
                 * cqss(sqssHCCO) - (HCO_CH2GL1G) * cqss(sqssCH2GL1G) &
                 - (HCO_C2H5) * cqss(sqssC2H5) - (a_i_a) * cqss(sqssCH3O)) &
                 / (a_h_a)  

    cqss(sqssH2O2) = H2O2_ct - (H2O2_CH3O) * cqss(sqssCH3O) - (H2O2_HCO) &
                 * cqss(sqssHCO)  

    cqss = max(cqss, tiny(1.0_pr))
    cqss = min(cqss, 1e03_pr)
    
    return
  end subroutine get_qss  
  
    
  ! ----------------------------------------------- !
  ! Mass fractions to concentrations                !
  ! ----------------------------------------------- !
  subroutine y2c(y, W_sp, P, T, c)
    implicit none

    real(pr),dimension(nspec) :: W_sp
    real(pr),dimension(nspec) :: c, y
    real(pr) :: rho, P, T, inv_W_g

    integer :: k
            
    ! Gas molecular weight inverse
    inv_W_g = 0.0_pr
    do k =1, nspec
      inv_W_g = inv_W_g + y(k) / W_sp(k)
    end do

    ! Gas density
    rho = P / (Rcst * inv_W_g * T)

    ! Conversion
    c = y * rho / W_sp

    ! Concentrations clipping
    !  c = max(c, tiny(1.0_pr))

        return
    end subroutine y2c

end module mod_customkinetics
! ----------------------------------------------- !
! Cantera routine                                 !
! ----------------------------------------------- !
subroutine customkinetics(P, T, y, wdot)

  use mod_customkinetics
  implicit none

  real(pr), dimension(nspec) :: y, c, wdot, cdot
  real(pr), dimension(nqss) :: cqss
  real(pr), dimension(nreac + nreac_reverse) :: w,k
  real(pr), dimension(nTB + nFO) :: M

  real(pr) :: P, T, rho

  ! Convert to concentrations
  call y2c(y, W_sp, P, T, c)

  ! Evaluate QSS concentrations and reaction rates
  call get_thirdbodies(M,c)

  call get_rate_coefficients(k, M, T, P)
  call get_qss(cqss, c, k, M)

  call get_reaction_rates(w, k, M, c, cqss)

  ! Evaluate production rates
  call get_production_rates(wdot,w)

  return
end subroutine customkinetics

