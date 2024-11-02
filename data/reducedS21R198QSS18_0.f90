!--------------------------------------------------------------------------------------------------
!     Copyright (c) CERFACS (all rights reserved)
!--------------------------------------------------------------------------------------------------
!     FILE S21R198QSS18_0.f90
!>    @file S21R198QSS18_0.f90
!!    Module for calculating the analytical source terms in Cantera
!!    @details 
!!    @authors 
!!    @date    2022/12/14
!!    @since   
!!    @note    
!--------------------------------------------------------------------------------------------------

!--------------------------------------------------------------------------------------------------
!     MODULE mod_customkinetics
!>    @details
!!    @authors
!!    @date    2022/12/14
!--------------------------------------------------------------------------------------------------
module mod_customkinetics
  implicit none

  integer, parameter :: pr = selected_real_kind(15,307)

  ! Ideal gas constant
  real(pr), parameter :: Rcst = 8.3144621_pr
  
  ! Use semi-implicit formulation for select species
  logical, parameter :: semiImplicit = .False.
  
  ! Number of elements in the chemical system 
  integer, parameter :: ne = 4
  
  ! Number of non-qss and qss species and reactions
  integer, parameter :: nspec = 21
  integer, parameter :: nqss = 18
  integer, parameter :: nreac = 192
  integer, parameter :: nreac_reverse = 178
  
  ! Actual expression of each reaction
  character(len=65), dimension(nreac + nreac_reverse) :: reacexp
  
  ! Number of thirdbodies
  integer, parameter :: nTB = 7
  integer, parameter :: nFO = 14
  integer, parameter :: nTB_reverse = 6
  integer, parameter :: nFO_reverse = 14
  
  ! Index of elements
  integer, parameter :: eN = 1
  integer, parameter :: eH = 2
  integer, parameter :: eO = 3
  integer, parameter :: eC = 4

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
  integer, parameter :: sCH3OH = 13
  integer, parameter :: sCH2O = 14
  integer, parameter :: sC2H4 = 15
  integer, parameter :: sNO = 16
  integer, parameter :: sN2O = 17
  integer, parameter :: sNO2 = 18
  integer, parameter :: sN = 19
  integer, parameter :: sHCN = 20
  integer, parameter :: sCH3NO2 = 21

  integer, parameter :: sqssH2O2 = 1
  integer, parameter :: sqssCH2 = 2
  integer, parameter :: sqssCH2GSG = 3
  integer, parameter :: sqssC = 4
  integer, parameter :: sqssCH = 5
  integer, parameter :: sqssCH3O2 = 6
  integer, parameter :: sqssCH3O = 7
  integer, parameter :: sqssHCO = 8
  integer, parameter :: sqssC2H6 = 9
  integer, parameter :: sqssC2H5 = 10
  integer, parameter :: sqssC2H3 = 11
  integer, parameter :: sqssHNO = 12
  integer, parameter :: sqssNH = 13
  integer, parameter :: sqssNNH = 14
  integer, parameter :: sqssCN = 15
  integer, parameter :: sqssNCN = 16
  integer, parameter :: sqssNCO = 17
  integer, parameter :: sqssH2CN = 18

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
  integer, parameter :: r155f = 155
  integer, parameter :: r156f = 156
  integer, parameter :: r157f = 157
  integer, parameter :: r158f = 158
  integer, parameter :: r159f = 159
  integer, parameter :: r160f = 160
  integer, parameter :: r161f = 161
  integer, parameter :: r162f = 162
  integer, parameter :: r163f = 163
  integer, parameter :: r164f = 164
  integer, parameter :: r165f = 165
  integer, parameter :: r166f = 166
  integer, parameter :: r167f = 167
  integer, parameter :: r168f = 168
  integer, parameter :: r169f = 169
  integer, parameter :: r170f = 170
  integer, parameter :: r171f = 171
  integer, parameter :: r172f = 172
  integer, parameter :: r173f = 173
  integer, parameter :: r174f = 174
  integer, parameter :: r175f = 175
  integer, parameter :: r176f = 176
  integer, parameter :: r177f = 177
  integer, parameter :: r178f = 178
  integer, parameter :: r179f = 179
  integer, parameter :: r180f = 180
  integer, parameter :: r181f = 181
  integer, parameter :: r182f = 182
  integer, parameter :: r183f = 183
  integer, parameter :: r184f = 184
  integer, parameter :: r185f = 185
  integer, parameter :: r186f = 186
  integer, parameter :: r187f = 187
  integer, parameter :: r188f = 188
  integer, parameter :: r189f = 189
  integer, parameter :: r190f = 190
  integer, parameter :: r191f = 191
  integer, parameter :: r192f = 192
  integer, parameter :: r1b = 193
  integer, parameter :: r2b = 194
  integer, parameter :: r3b = 195
  integer, parameter :: r4b = 196
  integer, parameter :: r5b = 197
  integer, parameter :: r6b = 198
  integer, parameter :: r7b = 199
  integer, parameter :: r8b = 200
  integer, parameter :: r9b = 201
  integer, parameter :: r10b = 202
  integer, parameter :: r11b = 203
  integer, parameter :: r12b = 204
  integer, parameter :: r13b = 205
  integer, parameter :: r14b = 206
  integer, parameter :: r15b = 207
  integer, parameter :: r16b = 208
  integer, parameter :: r17b = 209
  integer, parameter :: r18b = 210
  integer, parameter :: r19b = 211
  integer, parameter :: r20b = 212
  integer, parameter :: r21b = 213
  integer, parameter :: r22b = 214
  integer, parameter :: r23b = 215
  integer, parameter :: r24b = 216
  integer, parameter :: r25b = 217
  integer, parameter :: r26b = 218
  integer, parameter :: r27b = 219
  integer, parameter :: r28b = 220
  integer, parameter :: r29b = 221
  integer, parameter :: r30b = 222
  integer, parameter :: r32b = 223
  integer, parameter :: r33b = 224
  integer, parameter :: r34b = 225
  integer, parameter :: r35b = 226
  integer, parameter :: r36b = 227
  integer, parameter :: r37b = 228
  integer, parameter :: r38b = 229
  integer, parameter :: r39b = 230
  integer, parameter :: r42b = 231
  integer, parameter :: r43b = 232
  integer, parameter :: r44b = 233
  integer, parameter :: r45b = 234
  integer, parameter :: r46b = 235
  integer, parameter :: r47b = 236
  integer, parameter :: r48b = 237
  integer, parameter :: r49b = 238
  integer, parameter :: r50b = 239
  integer, parameter :: r51b = 240
  integer, parameter :: r52b = 241
  integer, parameter :: r53b = 242
  integer, parameter :: r54b = 243
  integer, parameter :: r55b = 244
  integer, parameter :: r56b = 245
  integer, parameter :: r57b = 246
  integer, parameter :: r58b = 247
  integer, parameter :: r59b = 248
  integer, parameter :: r60b = 249
  integer, parameter :: r61b = 250
  integer, parameter :: r62b = 251
  integer, parameter :: r63b = 252
  integer, parameter :: r64b = 253
  integer, parameter :: r65b = 254
  integer, parameter :: r66b = 255
  integer, parameter :: r67b = 256
  integer, parameter :: r68b = 257
  integer, parameter :: r69b = 258
  integer, parameter :: r70b = 259
  integer, parameter :: r71b = 260
  integer, parameter :: r72b = 261
  integer, parameter :: r73b = 262
  integer, parameter :: r74b = 263
  integer, parameter :: r75b = 264
  integer, parameter :: r76b = 265
  integer, parameter :: r77b = 266
  integer, parameter :: r78b = 267
  integer, parameter :: r79b = 268
  integer, parameter :: r80b = 269
  integer, parameter :: r81b = 270
  integer, parameter :: r82b = 271
  integer, parameter :: r83b = 272
  integer, parameter :: r84b = 273
  integer, parameter :: r85b = 274
  integer, parameter :: r86b = 275
  integer, parameter :: r87b = 276
  integer, parameter :: r88b = 277
  integer, parameter :: r89b = 278
  integer, parameter :: r90b = 279
  integer, parameter :: r91b = 280
  integer, parameter :: r92b = 281
  integer, parameter :: r93b = 282
  integer, parameter :: r94b = 283
  integer, parameter :: r95b = 284
  integer, parameter :: r96b = 285
  integer, parameter :: r99b = 286
  integer, parameter :: r100b = 287
  integer, parameter :: r101b = 288
  integer, parameter :: r102b = 289
  integer, parameter :: r105b = 290
  integer, parameter :: r106b = 291
  integer, parameter :: r107b = 292
  integer, parameter :: r108b = 293
  integer, parameter :: r109b = 294
  integer, parameter :: r116b = 295
  integer, parameter :: r117b = 296
  integer, parameter :: r118b = 297
  integer, parameter :: r119b = 298
  integer, parameter :: r120b = 299
  integer, parameter :: r121b = 300
  integer, parameter :: r122b = 301
  integer, parameter :: r123b = 302
  integer, parameter :: r124b = 303
  integer, parameter :: r125b = 304
  integer, parameter :: r126b = 305
  integer, parameter :: r127b = 306
  integer, parameter :: r128b = 307
  integer, parameter :: r129b = 308
  integer, parameter :: r130b = 309
  integer, parameter :: r131b = 310
  integer, parameter :: r132b = 311
  integer, parameter :: r133b = 312
  integer, parameter :: r134b = 313
  integer, parameter :: r135b = 314
  integer, parameter :: r136b = 315
  integer, parameter :: r137b = 316
  integer, parameter :: r138b = 317
  integer, parameter :: r139b = 318
  integer, parameter :: r140b = 319
  integer, parameter :: r141b = 320
  integer, parameter :: r142b = 321
  integer, parameter :: r143b = 322
  integer, parameter :: r144b = 323
  integer, parameter :: r145b = 324
  integer, parameter :: r146b = 325
  integer, parameter :: r147b = 326
  integer, parameter :: r148b = 327
  integer, parameter :: r149b = 328
  integer, parameter :: r150b = 329
  integer, parameter :: r151b = 330
  integer, parameter :: r152b = 331
  integer, parameter :: r153b = 332
  integer, parameter :: r154b = 333
  integer, parameter :: r155b = 334
  integer, parameter :: r156b = 335
  integer, parameter :: r157b = 336
  integer, parameter :: r158b = 337
  integer, parameter :: r159b = 338
  integer, parameter :: r160b = 339
  integer, parameter :: r161b = 340
  integer, parameter :: r162b = 341
  integer, parameter :: r163b = 342
  integer, parameter :: r164b = 343
  integer, parameter :: r165b = 344
  integer, parameter :: r166b = 345
  integer, parameter :: r167b = 346
  integer, parameter :: r168b = 347
  integer, parameter :: r169b = 348
  integer, parameter :: r170b = 349
  integer, parameter :: r171b = 350
  integer, parameter :: r172b = 351
  integer, parameter :: r173b = 352
  integer, parameter :: r174b = 353
  integer, parameter :: r175b = 354
  integer, parameter :: r176b = 355
  integer, parameter :: r177b = 356
  integer, parameter :: r178b = 357
  integer, parameter :: r179b = 358
  integer, parameter :: r180b = 359
  integer, parameter :: r181b = 360
  integer, parameter :: r182b = 361
  integer, parameter :: r183b = 362
  integer, parameter :: r185b = 363
  integer, parameter :: r186b = 364
  integer, parameter :: r187b = 365
  integer, parameter :: r188b = 366
  integer, parameter :: r189b = 367
  integer, parameter :: r190b = 368
  integer, parameter :: r191b = 369
  integer, parameter :: r192b = 370
  
  ! Index of third body species
  integer, parameter :: mM1 = 1
  integer, parameter :: mM5 = 2
  integer, parameter :: mM7 = 3
  integer, parameter :: mM73 = 4
  integer, parameter :: mM100 = 5
  integer, parameter :: mM113 = 6
  integer, parameter :: mM190 = 7
  
  integer, parameter :: mM8 = 8
  integer, parameter :: mM18 = 9
  integer, parameter :: mM19 = 10
  integer, parameter :: mM23 = 11
  integer, parameter :: mM51 = 12
  integer, parameter :: mM62 = 13
  integer, parameter :: mM80 = 14
  integer, parameter :: mM81 = 15
  integer, parameter :: mM82 = 16
  integer, parameter :: mM87 = 17
  integer, parameter :: mM132 = 18
  integer, parameter :: mM134 = 19
  integer, parameter :: mM176 = 20
  integer, parameter :: mM185 = 21
  
  ! Index of third body reactions
  integer, parameter :: TBr1f = 1
  integer, parameter :: TBr5f = 2
  integer, parameter :: TBr7f = 3
  integer, parameter :: TBr73f = 4
  integer, parameter :: TBr100f = 5
  integer, parameter :: TBr113f = 6
  integer, parameter :: TBr190f = 7
  integer, parameter :: TBr1b = 8
  integer, parameter :: TBr5b = 9
  integer, parameter :: TBr7b = 10
  integer, parameter :: TBr73b = 11
  integer, parameter :: TBr100b = 12
  integer, parameter :: TBr190b = 13
  
  ! Index of fall off reactions
  integer, parameter :: FOr8f = 1
  integer, parameter :: FOr18f = 2
  integer, parameter :: FOr19f = 3
  integer, parameter :: FOr23f = 4
  integer, parameter :: FOr51f = 5
  integer, parameter :: FOr62f = 6
  integer, parameter :: FOr80f = 7
  integer, parameter :: FOr81f = 8
  integer, parameter :: FOr82f = 9
  integer, parameter :: FOr87f = 10
  integer, parameter :: FOr132f = 11
  integer, parameter :: FOr134f = 12
  integer, parameter :: FOr176f = 13
  integer, parameter :: FOr185f = 14
  integer, parameter :: FOr8b = 15
  integer, parameter :: FOr18b = 16
  integer, parameter :: FOr19b = 17
  integer, parameter :: FOr23b = 18
  integer, parameter :: FOr51b = 19
  integer, parameter :: FOr62b = 20
  integer, parameter :: FOr80b = 21
  integer, parameter :: FOr81b = 22
  integer, parameter :: FOr82b = 23
  integer, parameter :: FOr87b = 24
  integer, parameter :: FOr132b = 25
  integer, parameter :: FOr134b = 26
  integer, parameter :: FOr176b = 27
  integer, parameter :: FOr185b = 28
  
  ! Molar mass
  real(pr), parameter, dimension(nspec) :: W_sp =(/ &
       2.801348e-02_pr, & ! N2
       2.015880e-03_pr, & ! H2
       1.007940e-03_pr, & ! H
       3.199880e-02_pr, & ! O2
       1.599940e-02_pr, & ! O
       1.801528e-02_pr, & ! H2O
       1.700734e-02_pr, & ! OH
       3.300674e-02_pr, & ! HO2
       2.801040e-02_pr, & ! CO
       4.400980e-02_pr, & ! CO2
       1.604276e-02_pr, & ! CH4
       1.503482e-02_pr, & ! CH3
       3.204216e-02_pr, & ! CH3OH
       3.002628e-02_pr, & ! CH2O
       2.805376e-02_pr, & ! C2H4
       3.000614e-02_pr, & ! NO
       4.401288e-02_pr, & ! N2O
       4.600554e-02_pr, & ! NO2
       1.400674e-02_pr, & ! N
       2.702568e-02_pr, & ! HCN
       6.104036e-02_pr & ! CH3NO2
      !3.401468e-02_pr, & ! H2O2
      !1.402688e-02_pr, & ! CH2
      !1.402688e-02_pr, & ! CH2GSG
      !1.201100e-02_pr, & ! C
      !1.301894e-02_pr, & ! CH
      !4.703362e-02_pr, & ! CH3O2
      !3.103422e-02_pr, & ! CH3O
      !2.901834e-02_pr, & ! HCO
      !3.006964e-02_pr, & ! C2H6
      !2.906170e-02_pr, & ! C2H5
      !2.704582e-02_pr, & ! C2H3
      !3.101408e-02_pr, & ! HNO
      !1.501468e-02_pr, & ! NH
      !2.902142e-02_pr, & ! NNH
      !2.601774e-02_pr, & ! CN
      !4.002448e-02_pr, & ! NCN
      !4.201714e-02_pr, & ! NCO
      !2.803362e-02_pr & ! H2CN
       /)
  
contains

  ! ----------------------------------------------- !
  ! Subroutine for pressure dependent coefficients  !
  ! ----------------------------------------------- !
  real(pr) function getlindratecoeff(Tloc,k0,kinf,fc,concin,Ploc)
    implicit none

    real(pr) ::  Tloc,k0,kinf,fc,redP,Ploc
    real(pr) :: ntmp,ccoeff,dcoeff,lgknull
    real(pr) :: f
    real(pr) :: conc, concin

    if (concin.gt.0.0_pr) then
       conc = concin
    else
       conc = Ploc / ( Rcst * Tloc )
    end if
    
    redP = abs(k0) * conc / max(abs(kinf), tiny(1.0_pr)) + tiny(1.0_pr)

    ntmp = 0.75_pr - 1.27_pr * log10( fc )
    ccoeff = - 0.4_pr - 0.67_pr * log10( fc )
    dcoeff = 0.14_pr
    lgknull = log10(redP)
    f = (lgknull+ccoeff)/(ntmp-dcoeff*(lgknull+ccoeff))
    f = fc**(1.0_pr / ( f * f + 1.0_pr ))
    
    getlindratecoeff = kinf * f * redP / ( 1.0_pr + redP )

  end function getlindratecoeff

  ! ----------------------------------------------- !
  ! Evaluate thirdbodies                            !
  ! ----------------------------------------------- !
  subroutine get_thirdbodies(M,c)
    implicit none

    real(pr), dimension(nspec) :: c
    real(pr), dimension(nTB + nFO) :: M

    M(mM1) = (1.000000e+00_pr)*c(sCH4) &
         + (9.000000e-01_pr)*c(sCO) &
         + (2.800000e+00_pr)*c(sCO2) &
         + (1.500000e+00_pr)*c(sH2) &
         + (1.100000e+01_pr)*c(sH2O) &
         + sum(c)

    M(mM5) = (1.000000e+00_pr)*c(sCH4) &
         + (-2.700000e-01_pr)*c(sH2) &
         + (2.650000e+00_pr)*c(sH2O) &
         + sum(c)

    M(mM7) = (1.000000e+00_pr)*c(sCH4) &
         + (5.000000e-01_pr)*c(sCO) &
         + (1.000000e+00_pr)*c(sCO2) &
         + (1.500000e+00_pr)*c(sH2) &
         + (1.100000e+01_pr)*c(sH2O) &
         + sum(c)

    M(mM73) = (1.000000e+00_pr)*c(sCH4) &
         + (5.000000e-01_pr)*c(sCO) &
         + (1.000000e+00_pr)*c(sCO2) &
         + (1.000000e+00_pr)*c(sH2) &
         + (5.000000e+00_pr)*c(sH2O) &
         + sum(c)

    M(mM100) = sum(c)

    M(mM113) = sum(c)

    M(mM190) = (1.000000e+00_pr)*c(sCH4) &
         + (5.000000e-01_pr)*c(sCO) &
         + (1.000000e+00_pr)*c(sCO2) &
         + (1.000000e+00_pr)*c(sH2) &
         + (5.000000e+00_pr)*c(sH2O) &
         + sum(c)

    M(mM8) = (1.800000e+00_pr)*c(sCO) &
         + (6.000000e-01_pr)*c(sCO2) &
         + (2.700000e+00_pr)*c(sH2) &
         + (6.650000e+00_pr)*c(sH2O) &
         + (5.000000e-01_pr)*c(sN2) &
         + (2.000000e-01_pr)*c(sO2) &
         + sum(c)

    M(mM18) = (1.000000e+00_pr)*c(sCH4) &
         + (9.000000e-01_pr)*c(sCO) &
         + (2.800000e+00_pr)*c(sCO2) &
         + (3.000000e-01_pr)*c(sH2) &
         + (9.000000e+00_pr)*c(sH2O) &
         + sum(c)

    M(mM19) = (7.500000e-01_pr)*c(sCO) &
         + (2.600000e+00_pr)*c(sCO2) &
         + (1.000000e+00_pr)*c(sH2) &
         + (1.100000e+01_pr)*c(sH2O) &
         + sum(c)

    M(mM23) = (1.000000e+00_pr)*c(sCH4) &
         + (5.000000e-01_pr)*c(sCO) &
         + (1.000000e+00_pr)*c(sCO2) &
         + (1.000000e+00_pr)*c(sH2) &
         + (5.000000e+00_pr)*c(sH2O) &
         + sum(c)

    M(mM51) = sum(c)

    M(mM62) = sum(c)

    M(mM80) = (1.000000e+00_pr)*c(sCH4) &
         + (5.000000e-01_pr)*c(sCO) &
         + (1.000000e+00_pr)*c(sCO2) &
         + (1.000000e+00_pr)*c(sH2) &
         + (5.000000e+00_pr)*c(sH2O) &
         + sum(c)

    M(mM81) = (1.000000e+00_pr)*c(sCO) &
         + (2.000000e+00_pr)*c(sCO2) &
         + (4.000000e+00_pr)*c(sH2O) &
         + sum(c)

    M(mM82) = (1.000000e+00_pr)*c(sCH4) &
         + (5.000000e-01_pr)*c(sCO) &
         + (1.000000e+00_pr)*c(sCO2) &
         + (1.000000e+00_pr)*c(sH2) &
         + (5.000000e+00_pr)*c(sH2O) &
         + sum(c)

    M(mM87) = (1.000000e+00_pr)*c(sCH4) &
         + (5.000000e-01_pr)*c(sCO) &
         + (1.000000e+00_pr)*c(sCO2) &
         + (1.000000e+00_pr)*c(sH2) &
         + (5.000000e+00_pr)*c(sH2O) &
         + sum(c)

    M(mM132) = (9.000000e+00_pr)*c(sH2O) &
         + (7.000000e-01_pr)*c(sN2) &
         + (5.000000e-01_pr)*c(sO2) &
         + sum(c)

    M(mM134) = sum(c)

    M(mM176) = (2.000000e+00_pr)*c(sCO2) &
         + (1.100000e+01_pr)*c(sH2O) &
         + (7.000000e-01_pr)*c(sN2) &
         + (4.000000e-01_pr)*c(sO2) &
         + sum(c)

    M(mM185) = sum(c)

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
    real(pr) :: Tloc,Ploc,R_T_inv,T_log,redP

    ! Rate coefficients
    R_T_inv = 1.0_pr/(Rcst*Tloc)
    T_log = log(Tloc)

    k(r1f) = (4.577000e+13_pr)*exp((-4.368096e+05_pr)*R_T_inv + (-1.400000e+00_pr)*T_log )
    k(r2f) = (5.080000e-02_pr)*exp((-2.632573e+04_pr)*R_T_inv + (2.670000e+00_pr)*T_log )
    k(r3f) = (4.380000e+07_pr)*exp((-2.924616e+04_pr)*R_T_inv )
    k(r4f) = (1.140000e+08_pr)*exp((-6.395662e+04_pr)*R_T_inv )
    k(r5f) = (3.500000e+10_pr)*exp((-2.000000e+00_pr)*T_log )
    k(r6f) = (6.700000e+01_pr)*exp((-6.270477e+04_pr)*R_T_inv + (1.704000e+00_pr)*T_log )
    k(r7f) = (4.714000e+06_pr)*exp((-1.000000e+00_pr)*T_log )
    k_0(FOr8f) =(2.490000e+18_pr)*exp((-2.039658e+05_pr)*R_T_inv + (-2.300000e+00_pr)*T_log )
    k_inf(FOr8f) =(2.000000e+12_pr)*exp((-2.039658e+05_pr)*R_T_inv + (9.000000e-01_pr)*T_log )
    FC(FOr8f) = ((1.0_pr - 4.300000e-01_pr)*exp(-Tloc/(1.000000e-30_pr)) + (4.300000e-01_pr)*exp(-Tloc/(1.000000e+30_pr)))
    k(r8f) = getlindratecoeff(Tloc, k_0(FOr8f), k_inf(FOr8f),FC(FOr8f), M(mM8),Ploc)
    k(r9f) = (2.150000e+04_pr)*exp((-2.510400e+04_pr)*R_T_inv + (1.000000e+00_pr)*T_log )
    k(r10f) = (7.590000e+07_pr)*exp((-3.041350e+04_pr)*R_T_inv )
    k(r11f) = (7.079000e+07_pr)*exp((-1.234280e+03_pr)*R_T_inv )
    k(r12f) = (1.140200e+04_pr)*exp((-2.317016e+03_pr)*R_T_inv + (1.083000e+00_pr)*T_log )
    k(r13f) = (3.250000e+07_pr)
    k(r14f) = (7.000000e+06_pr)*exp((4.572945e+03_pr)*R_T_inv )
    k(r15f) = (4.500000e+08_pr)*exp((-4.572945e+04_pr)*R_T_inv )
    k(r16f) = (1.000000e+08_pr)*exp((-4.619504e+04_pr)*R_T_inv )
    k(r17f) = (1.900000e+05_pr)*exp((5.894921e+03_pr)*R_T_inv )
    k_0(FOr18f) =(1.740000e+07_pr)*exp((-1.230000e+00_pr)*T_log )
    k_inf(FOr18f) =(4.650000e+06_pr)*exp((4.400000e-01_pr)*T_log )
    FC(FOr18f) = ((1.0_pr - 6.700000e-01_pr)*exp(-Tloc/(1.000000e-30_pr)) + (6.700000e-01_pr)*exp(-Tloc/(1.000000e+30_pr)))&
              + exp(-(1.000000e+30_pr)/Tloc)
    k(r18f) = getlindratecoeff(Tloc, k_0(FOr18f), k_inf(FOr18f),FC(FOr18f), M(mM18),Ploc)
    k_0(FOr19f) =(1.170000e+12_pr)*exp((-1.753514e+04_pr)*R_T_inv + (-2.790000e+00_pr)*T_log )
    k_inf(FOr19f) =(1.362000e+04_pr)*exp((-9.974656e+03_pr)*R_T_inv )
    redP = abs(k_0(FOr19f)) * M(mM19) / max(abs(k_inf(FOr19f)), tiny(1.0_pr)) + tiny(1.0_pr)
    k(r19f) = k_inf(FOr19f) * redP / ( 1.0_pr + redP )
    k(r20f) = (7.015000e-02_pr)*exp((1.488249e+03_pr)*R_T_inv + (2.053000e+00_pr)*T_log )
    k(r21f) = (5.757000e+06_pr)*exp((-1.388251e+03_pr)*R_T_inv + (-6.640000e-01_pr)*T_log )
    k(r22f) = (1.570000e-01_pr)*exp((-7.506096e+04_pr)*R_T_inv + (2.180000e+00_pr)*T_log )
    k_0(FOr23f) =(2.480000e+21_pr)*exp((-1.020896e+04_pr)*R_T_inv + (-4.760000e+00_pr)*T_log )
    k_inf(FOr23f) =(1.270000e+10_pr)*exp((-1.602472e+03_pr)*R_T_inv + (-6.300000e-01_pr)*T_log )
    FC(FOr23f) = ((1.0_pr - 7.830000e-01_pr)*exp(-Tloc/(7.400000e+01_pr)) + (7.830000e-01_pr)*exp(-Tloc/(2.941000e+03_pr)))&
              + exp(-(6.964000e+03_pr)/Tloc)
    k(r23f) = getlindratecoeff(Tloc, k_0(FOr23f), k_inf(FOr23f),FC(FOr23f), M(mM23),Ploc)
    k(r24f) = (6.140000e-01_pr)*exp((-4.011201e+04_pr)*R_T_inv + (2.500000e+00_pr)*T_log )
    k(r25f) = (1.020000e+03_pr)*exp((-3.598240e+04_pr)*R_T_inv + (1.500000e+00_pr)*T_log )
    k(r26f) = (5.830000e-02_pr)*exp((-9.162960e+03_pr)*R_T_inv + (2.600000e+00_pr)*T_log )
    k(r27f) = (1.130000e-05_pr)*exp((-8.790584e+04_pr)*R_T_inv + (3.740000e+00_pr)*T_log )
    k(r28f) = (1.160000e-01_pr)*exp((1.264405e+04_pr)*R_T_inv + (2.230000e+00_pr)*T_log )
    k(r29f) = (1.500000e+07_pr)*exp((-2.510400e+03_pr)*R_T_inv )
    k(r30f) = (3.000000e+07_pr)
    k(r31f) = (2.800000e+07_pr)
    k(r32f) = (1.200000e+07_pr)
    k(r33f) = (1.500000e+07_pr)
    k(r34f) = (1.500000e+07_pr)
    k(r35f) = (7.000000e+07_pr)
    k(r36f) = (3.000000e+07_pr)
    k(r37f) = (3.000000e+07_pr)
    k(r38f) = (1.400000e+07_pr)
    k(r39f) = (1.060000e+07_pr)*exp((-6.276000e+03_pr)*R_T_inv )
    k(r40f) = (2.640000e+06_pr)*exp((-6.276000e+03_pr)*R_T_inv )
    k(r41f) = (5.000000e+07_pr)
    k(r42f) = (3.000000e+07_pr)
    k(r43f) = (1.130000e+01_pr)*exp((-1.255200e+04_pr)*R_T_inv + (2.000000e+00_pr)*T_log )
    k(r44f) = (3.300000e+07_pr)
    k(r45f) = (5.700000e+07_pr)
    k(r46f) = (1.100000e+08_pr)
    k(r47f) = (3.000000e+07_pr)
    k(r48f) = (1.774000e+10_pr)*exp((-9.957920e+01_pr)*R_T_inv + (-1.220000e+00_pr)*T_log )
    k(r49f) = (5.000000e+07_pr)
    k(r50f) = (5.000000e+07_pr)
    k_0(FOr51f) =(6.850000e+12_pr)*exp((-3.000000e+00_pr)*T_log )
    k_inf(FOr51f) =(7.812000e+03_pr)*exp((9.000000e-01_pr)*T_log )
    FC(FOr51f) = ((1.0_pr - 6.000000e-01_pr)*exp(-Tloc/(1.000000e+03_pr)) + (6.000000e-01_pr)*exp(-Tloc/(7.000000e+01_pr)))&
              + exp(-(1.700000e+03_pr)/Tloc)
    k(r51f) = getlindratecoeff(Tloc, k_0(FOr51f), k_inf(FOr51f),FC(FOr51f), M(mM51),Ploc)
    k(r52f) = (7.546000e+06_pr)*exp((-1.184909e+05_pr)*R_T_inv )
    k(r53f) = (2.641000e-06_pr)*exp((-3.391132e+04_pr)*R_T_inv + (3.283000e+00_pr)*T_log )
    k(r54f) = (5.540000e+07_pr)*exp((5.690240e+02_pr)*R_T_inv + (5.000000e-02_pr)*T_log )
    k(r55f) = (5.282000e+11_pr)*exp((-7.414048e+03_pr)*R_T_inv + (-1.518000e+00_pr)*T_log )
    k(r56f) = (1.230000e+03_pr)*exp((-4.999880e+04_pr)*R_T_inv + (1.011000e+00_pr)*T_log )
    k(r57f) = (4.293000e-02_pr)*exp((-1.672680e+04_pr)*R_T_inv + (2.568000e+00_pr)*T_log )
    k(r58f) = (1.000000e+06_pr)*exp((2.876500e+03_pr)*R_T_inv + (2.690000e-01_pr)*T_log )
    k(r59f) = (3.600000e+07_pr)
    k(r60f) = (9.600000e+07_pr)
    k(r61f) = (6.000000e+07_pr)
    k_0(FOr62f) =(1.500000e+37_pr)*exp((-4.099994e+05_pr)*R_T_inv + (-6.995000e+00_pr)*T_log )
    k_inf(FOr62f) =(2.084000e+18_pr)*exp((-3.871899e+05_pr)*R_T_inv + (-6.150000e-01_pr)*T_log )
    FC(FOr62f) = ((1.0_pr - -4.748000e-01_pr)*exp(-Tloc/(3.558000e+04_pr)) + (-4.748000e-01_pr)*exp(-Tloc/(1.116000e+03_pr)))&
              + exp(-(9.023000e+03_pr)/Tloc)
    k(r62f) = getlindratecoeff(Tloc, k_0(FOr62f), k_inf(FOr62f),FC(FOr62f), M(mM62),Ploc)
    k(r63f) = (1.500000e-04_pr)*exp((3.192392e+03_pr)*R_T_inv + (3.030000e+00_pr)*T_log )
    k(r64f) = (3.580000e-02_pr)*exp((-1.789267e+05_pr)*R_T_inv + (2.270000e+00_pr)*T_log )
    k(r65f) = (4.380000e-25_pr)*exp((2.301618e+04_pr)*R_T_inv + (9.500000e+00_pr)*T_log )
    k(r66f) = (2.000000e+07_pr)
    k(r67f) = (1.200000e+07_pr)
    k(r68f) = (8.070000e+09_pr)*exp((-2.235093e+05_pr)*R_T_inv )
    k(r69f) = (6.260000e+03_pr)*exp((-9.455840e+03_pr)*R_T_inv + (1.150000e+00_pr)*T_log )
    k(r70f) = (5.740000e+01_pr)*exp((-1.146416e+04_pr)*R_T_inv + (1.900000e+00_pr)*T_log )
    k(r71f) = (7.820000e+01_pr)*exp((4.414120e+03_pr)*R_T_inv + (1.630000e+00_pr)*T_log )
    k(r72f) = (3.830000e-05_pr)*exp((-1.804141e+04_pr)*R_T_inv + (3.360000e+00_pr)*T_log )
    k(r73f) = (5.700000e+05_pr)*exp((-6.221608e+04_pr)*R_T_inv + (6.600000e-01_pr)*T_log )
    k(r74f) = (7.580000e+06_pr)*exp((-1.715440e+03_pr)*R_T_inv )
    k(r75f) = (3.020000e+07_pr)
    k(r76f) = (7.340000e+07_pr)
    k(r77f) = (3.011000e+07_pr)
    k(r78f) = (2.650000e+07_pr)
    k(r79f) = (3.000000e+07_pr)
    k_0(FOr80f) =(1.870000e+19_pr)*exp((-1.017005e+05_pr)*R_T_inv + (-3.000000e+00_pr)*T_log )
    k_inf(FOr80f) =(6.800000e+13_pr)*exp((-1.094953e+05_pr)*R_T_inv )
    FC(FOr80f) = ((1.0_pr - 9.000000e-01_pr)*exp(-Tloc/(2.500000e+03_pr)) + (9.000000e-01_pr)*exp(-Tloc/(1.300000e+03_pr)))&
              + exp(-(1.000000e+99_pr)/Tloc)
    k(r80f) = getlindratecoeff(Tloc, k_0(FOr80f), k_inf(FOr80f),FC(FOr80f), M(mM80),Ploc)
    k_0(FOr81f) =(8.050000e+19_pr)*exp((-4.107014e+03_pr)*R_T_inv + (-3.750000e+00_pr)*T_log )
    k_inf(FOr81f) =(2.277000e+09_pr)*exp((-7.317816e+02_pr)*R_T_inv + (-6.900000e-01_pr)*T_log )
    FC(FOr81f) = ((1.0_pr - 0.000000e+00_pr)*exp(-Tloc/(5.700000e+02_pr)) + (0.000000e+00_pr)*exp(-Tloc/(1.000000e+30_pr)))&
              + exp(-(1.000000e+30_pr)/Tloc)
    k(r81f) = getlindratecoeff(Tloc, k_0(FOr81f), k_inf(FOr81f),FC(FOr81f), M(mM81),Ploc)
    k_0(FOr82f) =(1.990000e+29_pr)*exp((-2.797004e+04_pr)*R_T_inv + (-7.080000e+00_pr)*T_log )
    k_inf(FOr82f) =(5.210000e+11_pr)*exp((-6.610720e+03_pr)*R_T_inv + (-9.900000e-01_pr)*T_log )
    FC(FOr82f) = ((1.0_pr - 8.420000e-01_pr)*exp(-Tloc/(1.250000e+02_pr)) + (8.420000e-01_pr)*exp(-Tloc/(2.219000e+03_pr)))&
              + exp(-(6.882000e+03_pr)/Tloc)
    k(r82f) = getlindratecoeff(Tloc, k_0(FOr82f), k_inf(FOr82f),FC(FOr82f), M(mM82),Ploc)
    k(r83f) = (3.550000e+00_pr)*exp((-2.439272e+04_pr)*R_T_inv + (2.400000e+00_pr)*T_log )
    k(r84f) = (1.150000e+02_pr)*exp((-3.150552e+04_pr)*R_T_inv + (1.900000e+00_pr)*T_log )
    k(r85f) = (1.480000e+01_pr)*exp((-3.974800e+03_pr)*R_T_inv + (1.900000e+00_pr)*T_log )
    k(r86f) = (5.550000e-10_pr)*exp((-1.351850e+04_pr)*R_T_inv + (4.720000e+00_pr)*T_log )
    k_0(FOr87f) =(1.420000e+27_pr)*exp((-2.413750e+04_pr)*R_T_inv + (-6.642000e+00_pr)*T_log )
    k_inf(FOr87f) =(9.569000e+02_pr)*exp((-5.669320e+03_pr)*R_T_inv + (1.463000e+00_pr)*T_log )
    FC(FOr87f) = ((1.0_pr - -5.690000e-01_pr)*exp(-Tloc/(2.990000e+02_pr)) + (-5.690000e-01_pr)*exp(-Tloc/(-9.147000e+03_pr)))&
              + exp(-(1.524000e+02_pr)/Tloc)
    k(r87f) = getlindratecoeff(Tloc, k_0(FOr87f), k_inf(FOr87f),FC(FOr87f), M(mM87),Ploc)
    k(r88f) = (3.100000e+08_pr)*exp((-5.595054e+04_pr)*R_T_inv + (-3.620000e-01_pr)*T_log )
    k(r89f) = (1.843000e+01_pr)*exp((3.014990e+03_pr)*R_T_inv + (1.130000e+00_pr)*T_log )
    k(r90f) = (5.070000e+01_pr)*exp((-5.418280e+04_pr)*R_T_inv + (1.930000e+00_pr)*T_log )
    k(r91f) = (2.230000e-02_pr)*exp((-9.269652e+03_pr)*R_T_inv + (2.745000e+00_pr)*T_log )
    k(r92f) = (9.760000e-04_pr)*exp((-6.337923e+04_pr)*R_T_inv + (2.947000e+00_pr)*T_log )
    k(r93f) = (7.453000e+00_pr)*exp((-7.656720e+02_pr)*R_T_inv + (1.880000e+00_pr)*T_log )
    k(r94f) = (6.000000e+07_pr)
    k(r95f) = (2.730000e+29_pr)*exp((-4.945488e+04_pr)*R_T_inv + (-7.320000e+00_pr)*T_log )
    k(r96f) = (6.080000e+09_pr)*exp((-2.701609e+03_pr)*R_T_inv + (-1.310000e+00_pr)*T_log )
    k(r97f) = (6.360000e+29_pr)*exp((-4.945488e+04_pr)*R_T_inv + (-7.320000e+00_pr)*T_log )
    k(r98f) = (1.420000e+10_pr)*exp((-2.701609e+03_pr)*R_T_inv + (-1.310000e+00_pr)*T_log )
    k(r99f) = (1.030000e+05_pr)*exp((3.128795e+03_pr)*R_T_inv + (-3.300000e-01_pr)*T_log )
    k(r100f) = (1.000000e+04_pr)
    k(r101f) = (4.000000e+01_pr)*exp((-1.255200e+04_pr)*R_T_inv + (2.000000e+00_pr)*T_log )
    k(r102f) = (1.500000e+13_pr)*exp((-1.966480e+05_pr)*R_T_inv )
    k(r103f) = (3.000000e+06_pr)
    k(r104f) = (5.000000e+04_pr)
    k(r105f) = (5.000000e+07_pr)
    k(r106f) = (3.000000e+07_pr)
    k(r107f) = (3.000000e+07_pr)
    k(r108f) = (4.300000e+07_pr)
    k(r109f) = (3.000000e+13_pr)*exp((-3.284440e+05_pr)*R_T_inv )
    k(r110f) = (2.000000e+07_pr)*exp((-2.092000e+04_pr)*R_T_inv )
    k(r111f) = (1.000000e+05_pr)
    k(r112f) = (1.000000e+08_pr)*exp((-1.799120e+05_pr)*R_T_inv )
    k(r113f) = (5.000000e+04_pr)
    k(r114f) = (1.500000e+07_pr)
    k(r115f) = (1.880000e+01_pr)*exp((-3.371271e+04_pr)*R_T_inv + (2.000000e+00_pr)*T_log )
    k(r116f) = (3.500000e+07_pr)*exp((-7.232881e+03_pr)*R_T_inv )
    k(r117f) = (7.000000e+07_pr)
    k(r118f) = (3.810000e+08_pr)*exp((1.924640e+02_pr)*R_T_inv + (-3.760000e-01_pr)*T_log )
    k(r119f) = (1.570000e+01_pr)*exp((2.426720e+03_pr)*R_T_inv + (1.740000e+00_pr)*T_log )
    k(r120f) = (1.000000e+07_pr)
    k(r121f) = (2.010000e+09_pr)*exp((-2.372328e+04_pr)*R_T_inv + (-1.380000e+00_pr)*T_log )
    k(r122f) = (2.700000e+06_pr)*exp((2.142208e+03_pr)*R_T_inv + (-7.200000e-02_pr)*T_log )
    k(r123f) = (1.800000e+08_pr)*exp((1.020896e+03_pr)*R_T_inv + (-3.510000e-01_pr)*T_log )
    k(r124f) = (2.830000e+07_pr)
    k(r125f) = (9.027000e+03_pr)*exp((-2.719600e+04_pr)*R_T_inv + (1.000000e+00_pr)*T_log )
    k(r126f) = (4.280000e+07_pr)*exp((-6.568880e+03_pr)*R_T_inv )
    k(r127f) = (1.000000e+09_pr)
    k(r128f) = (1.900000e+08_pr)*exp((9.204800e+01_pr)*R_T_inv + (-2.740000e-01_pr)*T_log )
    k(r129f) = (5.200000e+05_pr)*exp((1.711256e+03_pr)*R_T_inv + (3.880000e-01_pr)*T_log )
    k(r130f) = (5.600000e+08_pr)*exp((5.439200e+01_pr)*R_T_inv + (-3.850000e-01_pr)*T_log )
    k(r131f) = (2.110000e+06_pr)*exp((2.008320e+03_pr)*R_T_inv )
    k_0(FOr132f) =(4.720000e+12_pr)*exp((-6.485200e+03_pr)*R_T_inv + (-2.870000e+00_pr)*T_log )
    k_inf(FOr132f) =(1.300000e+09_pr)*exp((-7.500000e-01_pr)*T_log )
    FC(FOr132f) = ((1.0_pr - 7.500000e-01_pr)*exp(-Tloc/(1.000000e+03_pr)) + (7.500000e-01_pr)*exp(-Tloc/(1.000000e+05_pr)))&
              + exp(-(1.000000e+30_pr)/Tloc)
    k(r132f) = getlindratecoeff(Tloc, k_0(FOr132f), k_inf(FOr132f),FC(FOr132f), M(mM132),Ploc)
    k(r133f) = (6.900000e+06_pr)
    k_0(FOr134f) =(2.400000e+02_pr)*exp((6.485200e+03_pr)*R_T_inv + (2.060000e-01_pr)*T_log )
    k_inf(FOr134f) =(1.500000e+09_pr)*exp((-4.100000e-01_pr)*T_log )
    FC(FOr134f) = ((1.0_pr - 8.200000e-01_pr)*exp(-Tloc/(1.000000e-30_pr)) + (8.200000e-01_pr)*exp(-Tloc/(1.000000e+30_pr)))&
              + exp(-(1.000000e+30_pr)/Tloc)
    k(r134f) = getlindratecoeff(Tloc, k_0(FOr134f), k_inf(FOr134f),FC(FOr134f), M(mM134),Ploc)
    k(r135f) = (9.680000e+05_pr)*exp((-1.506240e+03_pr)*R_T_inv + (6.200000e-01_pr)*T_log )
    k(r136f) = (2.290000e+07_pr)
    k(r137f) = (2.000000e+07_pr)*exp((-6.650886e+04_pr)*R_T_inv )
    k(r138f) = (8.510000e+06_pr)*exp((-1.238882e+05_pr)*R_T_inv )
    k(r139f) = (1.470000e+05_pr)*exp((-1.464400e+03_pr)*R_T_inv + (7.600000e-01_pr)*T_log )
    k(r140f) = (2.000000e+05_pr)*exp((4.426672e+03_pr)*R_T_inv + (8.400000e-01_pr)*T_log )
    k(r141f) = (3.920000e+06_pr)*exp((9.957920e+02_pr)*R_T_inv )
    k(r142f) = (1.630000e+06_pr)*exp((-1.089095e+05_pr)*R_T_inv )
    k(r143f) = (2.300000e+07_pr)
    k(r144f) = (7.600000e+04_pr)*exp((-3.267244e+04_pr)*R_T_inv + (4.800000e-01_pr)*T_log )
    k(r145f) = (4.000000e+08_pr)*exp((-3.562383e+04_pr)*R_T_inv + (-6.500000e-01_pr)*T_log )
    k(r146f) = (1.450000e+07_pr)*exp((-4.560560e+04_pr)*R_T_inv )
    k(r147f) = (1.100000e-01_pr)*exp((-7.983072e+03_pr)*R_T_inv + (2.600000e+00_pr)*T_log )
    k(r148f) = (2.140000e+08_pr)*exp((-1.800000e-01_pr)*T_log )
    k(r149f) = (4.000000e+07_pr)
    k(r150f) = (2.800000e+11_pr)*exp((-2.000000e+00_pr)*T_log )
    k(r151f) = (5.760000e+06_pr)*exp((1.745565e+03_pr)*R_T_inv )
    k(r152f) = (7.200000e+07_pr)*exp((-4.184000e+03_pr)*R_T_inv )
    k(r153f) = (5.790000e+12_pr)*exp((-4.644240e+03_pr)*R_T_inv + (-1.970000e+00_pr)*T_log )
    k(r154f) = (6.410000e+10_pr)*exp((-3.012480e+03_pr)*R_T_inv + (-1.340000e+00_pr)*T_log )
    k(r155f) = (9.770000e+04_pr)*exp((-7.301080e+04_pr)*R_T_inv )
    k(r156f) = (6.000000e+31_pr)*exp((-1.343482e+05_pr)*R_T_inv + (-6.460000e+00_pr)*T_log )
    k(r157f) = (2.400000e+02_pr)*exp((3.740496e+03_pr)*R_T_inv + (1.500000e+00_pr)*T_log )
    k(r158f) = (1.700000e+02_pr)*exp((3.740496e+03_pr)*R_T_inv + (1.500000e+00_pr)*T_log )
    k(r159f) = (3.000000e+06_pr)*exp((-2.494082e+04_pr)*R_T_inv )
    k(r160f) = (1.930000e+05_pr)*exp((-1.422560e+04_pr)*R_T_inv )
    k(r161f) = (6.100000e+08_pr)*exp((-1.213360e+03_pr)*R_T_inv + (-3.100000e-01_pr)*T_log )
    k(r162f) = (2.200000e+03_pr)*exp((-4.905029e+04_pr)*R_T_inv + (7.500000e-01_pr)*T_log )
    k(r163f) = (5.000000e+07_pr)
    k(r164f) = (5.240000e+07_pr)*exp((-1.879034e+05_pr)*R_T_inv )
    k(r165f) = (2.020000e+08_pr)*exp((-3.100000e-01_pr)*T_log )
    k(r166f) = (2.900000e+07_pr)*exp((-2.000000e-02_pr)*T_log )
    k(r167f) = (5.300000e+07_pr)
    k(r168f) = (2.000000e+07_pr)
    k(r169f) = (2.900000e+07_pr)
    k(r170f) = (5.500000e+06_pr)
    k(r171f) = (2.900000e+08_pr)*exp((-3.159338e+03_pr)*R_T_inv + (-6.900000e-01_pr)*T_log )
    k(r172f) = (8.100000e+01_pr)*exp((-1.720921e+04_pr)*R_T_inv + (1.420000e+00_pr)*T_log )
    k(r173f) = (7.800000e+09_pr)*exp((-2.560608e+02_pr)*R_T_inv + (-6.860000e-01_pr)*T_log )
    k(r174f) = (7.000000e+15_pr)*exp((-4.288600e+03_pr)*R_T_inv + (-3.382000e+00_pr)*T_log )
    k(r175f) = (6.020000e-02_pr)*exp((1.828408e+03_pr)*R_T_inv + (2.640000e+00_pr)*T_log )
    k_0(FOr176f) =(6.020000e+08_pr)*exp((-2.403457e+05_pr)*R_T_inv )
    k_inf(FOr176f) =(9.900000e+10_pr)*exp((-2.422578e+05_pr)*R_T_inv )
    redP = abs(k_0(FOr176f)) * M(mM176) / max(abs(k_inf(FOr176f)), tiny(1.0_pr)) + tiny(1.0_pr)
    k(r176f) = k_inf(FOr176f) * redP / ( 1.0_pr + redP )
    k(r177f) = (2.530000e+04_pr)*exp((-1.903720e+04_pr)*R_T_inv )
    k(r178f) = (5.000000e+08_pr)*exp((-7.573040e+04_pr)*R_T_inv )
    k(r179f) = (6.620000e+07_pr)*exp((-1.114199e+05_pr)*R_T_inv )
    k(r180f) = (1.020000e+08_pr)*exp((-1.172357e+05_pr)*R_T_inv )
    k(r181f) = (1.000000e-08_pr)*exp((-1.529670e+05_pr)*R_T_inv + (4.720000e+00_pr)*T_log )
    k(r182f) = (1.690000e+06_pr)*exp((2.384880e+03_pr)*R_T_inv )
    k(r183f) = (4.000000e+07_pr)*exp((-2.000000e-01_pr)*T_log )
    k(r184f) = (1.000000e+06_pr)
    k_0(FOr185f) =(1.260000e+11_pr)*exp((-1.757280e+05_pr)*R_T_inv )
    k_inf(FOr185f) =(1.780000e+16_pr)*exp((-2.447640e+05_pr)*R_T_inv )
    FC(FOr185f) = ((1.0_pr - 1.830000e-01_pr)*exp(-Tloc/(1.000000e-30_pr)) + (1.830000e-01_pr)*exp(-Tloc/(1.000000e+30_pr)))
    k(r185f) = getlindratecoeff(Tloc, k_0(FOr185f), k_inf(FOr185f),FC(FOr185f), M(mM185),Ploc)
    k(r186f) = (1.300000e+08_pr)*exp((-7.000000e-01_pr)*T_log )
    k(r187f) = (4.096000e+02_pr)*exp((-7.331791e+04_pr)*R_T_inv + (1.122000e+00_pr)*T_log )
    k(r188f) = (3.490000e+08_pr)*exp((-3.328790e+04_pr)*R_T_inv )
    k(r189f) = (9.600000e+07_pr)*exp((-5.794840e+03_pr)*R_T_inv )
    k(r190f) = (1.300000e+08_pr)*exp((-2.083632e+04_pr)*R_T_inv + (-1.100000e-01_pr)*T_log )
    k(r191f) = (4.710000e+04_pr)*exp((-1.673516e+04_pr)*R_T_inv + (4.400000e-01_pr)*T_log )
    k(r192f) = (1.200000e+07_pr)*exp((9.079280e+02_pr)*R_T_inv + (1.450000e-01_pr)*T_log )
    k(r1b) = (2.598477e+08_pr)*exp((-4.054129e+03_pr)*R_T_inv + (-1.784129e+00_pr)*T_log )
    k(r2b) = (2.502565e-02_pr)*exp((-2.013635e+04_pr)*R_T_inv + (2.658110e+00_pr)*T_log )
    k(r3b) = (1.527374e+08_pr)*exp((-9.105995e+04_pr)*R_T_inv + (3.945817e-02_pr)*T_log )
    k(r4b) = (4.965349e+05_pr)*exp((6.110298e+03_pr)*R_T_inv + (3.373898e-01_pr)*T_log )
    k(r5b) = (2.149816e+16_pr)*exp((-4.945693e+05_pr)*R_T_inv + (-1.576413e+00_pr)*T_log )
    k(r6b) = (9.465100e+00_pr)*exp((5.298392e+03_pr)*R_T_inv + (1.652652e+00_pr)*T_log )
    k(r7b) = (4.090470e+11_pr)*exp((-4.265661e+05_pr)*R_T_inv + (-6.277603e-01_pr)*T_log )
    k_0(FOr8b) =(8.223514e+07_pr)*exp((7.607995e+03_pr)*R_T_inv + (-1.584082e+00_pr)*T_log )
    k_inf(FOr8b) =(6.605232e+01_pr)*exp((7.607995e+03_pr)*R_T_inv + (1.615918e+00_pr)*T_log )
    FC(FOr8b) = ((1.0_pr - 4.300000e-01_pr)*exp(-Tloc/(1.000000e-30_pr)) + (4.300000e-01_pr)*exp(-Tloc/(1.000000e+30_pr)))
    k(r8b) = getlindratecoeff(Tloc, k_0(FOr8b), k_inf(FOr8b),FC(FOr8b), M(mM8),Ploc)
    k(r9b) = (2.051812e+02_pr)*exp((-9.362314e+04_pr)*R_T_inv + (1.474859e+00_pr)*T_log )
    k(r10b) = (2.525876e+06_pr)*exp((-1.607464e+05_pr)*R_T_inv + (5.143167e-01_pr)*T_log )
    k(r11b) = (4.315121e+04_pr)*exp((-1.538968e+05_pr)*R_T_inv + (6.251890e-01_pr)*T_log )
    k(r12b) = (3.239183e+03_pr)*exp((-2.312358e+05_pr)*R_T_inv + (1.382689e+00_pr)*T_log )
    k(r13b) = (4.548408e+06_pr)*exp((-2.227294e+05_pr)*R_T_inv + (2.877992e-01_pr)*T_log )
    k(r14b) = (6.934637e+06_pr)*exp((-2.861597e+05_pr)*R_T_inv + (3.391470e-01_pr)*T_log )
    k(r15b) = (4.457981e+08_pr)*exp((-3.364621e+05_pr)*R_T_inv + (3.391470e-01_pr)*T_log )
    k(r16b) = (2.976839e+09_pr)*exp((-2.065947e+05_pr)*R_T_inv + (-1.751697e-01_pr)*T_log )
    k(r17b) = (5.655995e+06_pr)*exp((-1.545048e+05_pr)*R_T_inv + (-1.751697e-01_pr)*T_log )
    k_0(FOr18b) =(1.078839e+13_pr)*exp((-2.038366e+05_pr)*R_T_inv + (-1.145560e+00_pr)*T_log )
    k_inf(FOr18b) =(2.883105e+12_pr)*exp((-2.038366e+05_pr)*R_T_inv + (5.244405e-01_pr)*T_log )
    FC(FOr18b) = ((1.0_pr - 6.700000e-01_pr)*exp(-Tloc/(1.000000e-30_pr)) + (6.700000e-01_pr)*exp(-Tloc/(1.000000e+30_pr)))&
              + exp(-(1.000000e+30_pr)/Tloc)
    k(r18b) = getlindratecoeff(Tloc, k_0(FOr18b), k_inf(FOr18b),FC(FOr18b), M(mM18),Ploc)
    k_0(FOr19b) =(1.299996e+23_pr)*exp((-5.502999e+05_pr)*R_T_inv + (-3.512504e+00_pr)*T_log )
    k_inf(FOr19b) =(1.513329e+15_pr)*exp((-5.427394e+05_pr)*R_T_inv + (-7.225039e-01_pr)*T_log )
    redP = abs(k_0(FOr19b)) * M(mM19) / max(abs(k_inf(FOr19b)), tiny(1.0_pr)) + tiny(1.0_pr)
    k(r19b) = k_inf(FOr19b) * redP / ( 1.0_pr + redP )
    k(r20b) = (8.982563e+04_pr)*exp((-1.047104e+05_pr)*R_T_inv + (9.582565e-01_pr)*T_log )
    k(r21b) = (7.371720e+12_pr)*exp((-1.075869e+05_pr)*R_T_inv + (-1.758744e+00_pr)*T_log )
    k(r22b) = (1.225443e+02_pr)*exp((-3.339221e+05_pr)*R_T_inv + (1.710445e+00_pr)*T_log )
    k_0(FOr23b) =(2.729208e+28_pr)*exp((-4.482999e+05_pr)*R_T_inv + (-4.475460e+00_pr)*T_log )
    k_inf(FOr23b) =(1.397619e+17_pr)*exp((-4.396934e+05_pr)*R_T_inv + (-3.454597e-01_pr)*T_log )
    FC(FOr23b) = ((1.0_pr - 7.830000e-01_pr)*exp(-Tloc/(7.400000e+01_pr)) + (7.830000e-01_pr)*exp(-Tloc/(2.941000e+03_pr)))&
              + exp(-(6.964000e+03_pr)/Tloc)
    k(r23b) = getlindratecoeff(Tloc, k_0(FOr23b), k_inf(FOr23b),FC(FOr23b), M(mM23),Ploc)
    k(r24b) = (9.827553e-03_pr)*exp((-3.477655e+04_pr)*R_T_inv + (2.599589e+00_pr)*T_log )
    k(r25b) = (8.042644e+00_pr)*exp((-2.445757e+04_pr)*R_T_inv + (1.587699e+00_pr)*T_log )
    k(r26b) = (3.253995e-03_pr)*exp((-6.564129e+04_pr)*R_T_inv + (2.739047e+00_pr)*T_log )
    k(r27b) = (1.895206e-05_pr)*exp((-1.405125e+04_pr)*R_T_inv + (3.364730e+00_pr)*T_log )
    k(r28b) = (2.058905e+00_pr)*exp((-2.216102e+05_pr)*R_T_inv + (2.430100e+00_pr)*T_log )
    k(r29b) = (1.288428e+07_pr)*exp((-4.010392e+04_pr)*R_T_inv + (-8.007696e-02_pr)*T_log )
    k(r30b) = (2.576857e+07_pr)*exp((-3.759352e+04_pr)*R_T_inv + (-8.007696e-02_pr)*T_log )
    k(r32b) = (1.462556e+06_pr)*exp((-7.796959e+05_pr)*R_T_inv + (4.356843e-01_pr)*T_log )
    k(r33b) = (1.203668e+08_pr)*exp((-7.879490e+05_pr)*R_T_inv + (5.883611e-02_pr)*T_log )
    k(r34b) = (1.133763e+09_pr)*exp((-4.196901e+05_pr)*R_T_inv + (-4.214259e-01_pr)*T_log )
    k(r35b) = (5.142227e+09_pr)*exp((-6.590343e+04_pr)*R_T_inv + (-3.971063e-01_pr)*T_log )
    k(r36b) = (4.208347e+06_pr)*exp((-4.979906e+04_pr)*R_T_inv + (8.692002e-02_pr)*T_log )
    k(r37b) = (1.695367e+11_pr)*exp((-3.601770e+05_pr)*R_T_inv + (-5.035736e-01_pr)*T_log )
    k(r38b) = (6.178711e+04_pr)*exp((-2.539783e+05_pr)*R_T_inv + (5.911700e-01_pr)*T_log )
    k(r39b) = (4.062685e+06_pr)*exp((-3.183057e+05_pr)*R_T_inv + (-3.959214e-03_pr)*T_log )
    k(r42b) = (4.899395e+06_pr)*exp((-1.220555e+04_pr)*R_T_inv + (1.669970e-01_pr)*T_log )
    k(r43b) = (6.435331e+00_pr)*exp((-8.657133e+04_pr)*R_T_inv + (2.206455e+00_pr)*T_log )
    k(r44b) = (1.572092e+08_pr)*exp((-3.060135e+05_pr)*R_T_inv + (-1.590665e-01_pr)*T_log )
    k(r45b) = (3.260615e+09_pr)*exp((-7.381500e+05_pr)*R_T_inv + (-2.808377e-02_pr)*T_log )
    k(r46b) = (9.832954e+07_pr)*exp((-9.689671e+04_pr)*R_T_inv + (1.654707e-01_pr)*T_log )
    k(r47b) = (3.281258e+10_pr)*exp((-3.760804e+05_pr)*R_T_inv + (-4.964563e-01_pr)*T_log )
    k(r48b) = (2.049437e+14_pr)*exp((-2.486637e+05_pr)*R_T_inv + (-1.849952e+00_pr)*T_log )
    k(r49b) = (6.495039e+09_pr)*exp((-6.474426e+05_pr)*R_T_inv + (-1.816648e-01_pr)*T_log )
    k(r50b) = (2.828959e+07_pr)*exp((-5.773757e+05_pr)*R_T_inv + (1.557250e-01_pr)*T_log )
    k_0(FOr51b) =(1.761765e+23_pr)*exp((-1.357737e+05_pr)*R_T_inv + (-3.753335e+00_pr)*T_log )
    k_inf(FOr51b) =(2.009184e+14_pr)*exp((-1.357737e+05_pr)*R_T_inv + (1.466649e-01_pr)*T_log )
    FC(FOr51b) = ((1.0_pr - 6.000000e-01_pr)*exp(-Tloc/(1.000000e+03_pr)) + (6.000000e-01_pr)*exp(-Tloc/(7.000000e+01_pr)))&
              + exp(-(1.700000e+03_pr)/Tloc)
    k(r51b) = getlindratecoeff(Tloc, k_0(FOr51b), k_inf(FOr51b),FC(FOr51b), M(mM51),Ploc)
    k(r52b) = (4.542525e+09_pr)*exp((1.920019e+03_pr)*R_T_inv + (-8.260317e-01_pr)*T_log )
    k(r53b) = (4.359375e-07_pr)*exp((-2.519286e+05_pr)*R_T_inv + (3.502033e+00_pr)*T_log )
    k(r54b) = (2.099523e+09_pr)*exp((-2.875151e+05_pr)*R_T_inv + (-6.835684e-02_pr)*T_log )
    k(r55b) = (2.507358e+10_pr)*exp((-3.324410e+03_pr)*R_T_inv + (-1.081435e+00_pr)*T_log )
    k(r56b) = (1.699968e+08_pr)*exp((3.451772e+02_pr)*R_T_inv + (-1.524215e-01_pr)*T_log )
    k(r57b) = (1.750443e-03_pr)*exp((-5.023068e+04_pr)*R_T_inv + (2.924488e+00_pr)*T_log )
    k(r58b) = (8.424742e+07_pr)*exp((-9.944205e+04_pr)*R_T_inv + (-2.692325e-01_pr)*T_log )
    k(r59b) = (1.678665e+07_pr)*exp((-2.404484e+05_pr)*R_T_inv + (-3.784679e-02_pr)*T_log )
    k(r60b) = (1.949745e+05_pr)*exp((-1.703815e+05_pr)*R_T_inv + (2.995431e-01_pr)*T_log )
    k(r61b) = (7.741751e+06_pr)*exp((-2.502203e+05_pr)*R_T_inv + (4.803257e-01_pr)*T_log )
    k_0(FOr62b) =(4.520076e+27_pr)*exp((-2.400535e+04_pr)*R_T_inv + (-6.721991e+00_pr)*T_log )
    k_inf(FOr62b) =(6.279893e+08_pr)*exp((-1.195855e+03_pr)*R_T_inv + (-3.419907e-01_pr)*T_log )
    FC(FOr62b) = ((1.0_pr - -4.748000e-01_pr)*exp(-Tloc/(3.558000e+04_pr)) + (-4.748000e-01_pr)*exp(-Tloc/(1.116000e+03_pr)))&
              + exp(-(9.023000e+03_pr)/Tloc)
    k(r62b) = getlindratecoeff(Tloc, k_0(FOr62b), k_inf(FOr62b),FC(FOr62b), M(mM62),Ploc)
    k(r63b) = (3.837201e-03_pr)*exp((-5.503887e+04_pr)*R_T_inv + (2.563175e+00_pr)*T_log )
    k(r64b) = (9.244444e-01_pr)*exp((5.357467e+04_pr)*R_T_inv + (1.464028e+00_pr)*T_log )
    k(r65b) = (8.581700e-28_pr)*exp((-9.268251e+04_pr)*R_T_inv + (1.025727e+01_pr)*T_log )
    k(r66b) = (1.113227e+04_pr)*exp((-3.446175e+05_pr)*R_T_inv + (1.056954e+00_pr)*T_log )
    k(r67b) = (4.173091e+05_pr)*exp((-3.499530e+05_pr)*R_T_inv + (9.573653e-01_pr)*T_log )
    k(r68b) = (7.712339e+08_pr)*exp((-6.029300e+04_pr)*R_T_inv + (-2.056516e-01_pr)*T_log )
    k(r69b) = (8.372651e+01_pr)*exp((-6.896901e+04_pr)*R_T_inv + (1.232148e+00_pr)*T_log )
    k(r70b) = (1.558400e+00_pr)*exp((-7.716670e+04_pr)*R_T_inv + (1.994037e+00_pr)*T_log )
    k(r71b) = (7.403635e+00_pr)*exp((-1.231022e+05_pr)*R_T_inv + (1.763495e+00_pr)*T_log )
    k(r72b) = (6.496639e-05_pr)*exp((-8.907941e+04_pr)*R_T_inv + (3.354448e+00_pr)*T_log )
    k(r73b) = (3.435554e-01_pr)*exp((2.280501e+03_pr)*R_T_inv + (7.561329e-01_pr)*T_log )
    k(r74b) = (2.832687e+06_pr)*exp((-1.410555e+05_pr)*R_T_inv + (1.805734e-01_pr)*T_log )
    k(r75b) = (1.579474e+06_pr)*exp((-3.620695e+05_pr)*R_T_inv + (4.683726e-01_pr)*T_log )
    k(r76b) = (7.792557e+06_pr)*exp((-3.682589e+05_pr)*R_T_inv + (4.802622e-01_pr)*T_log )
    k(r77b) = (1.114720e+07_pr)*exp((-4.300727e+05_pr)*R_T_inv + (5.197204e-01_pr)*T_log )
    k(r78b) = (1.757732e+08_pr)*exp((-3.735943e+05_pr)*R_T_inv + (3.806732e-01_pr)*T_log )
    k(r79b) = (2.009090e+12_pr)*exp((-4.682681e+05_pr)*R_T_inv + (-6.263710e-01_pr)*T_log )
    k_0(FOr80b) =(5.909262e+10_pr)*exp((-1.356253e+04_pr)*R_T_inv + (-2.327175e+00_pr)*T_log )
    k_inf(FOr80b) =(2.148823e+05_pr)*exp((-2.135733e+04_pr)*R_T_inv + (6.728250e-01_pr)*T_log )
    FC(FOr80b) = ((1.0_pr - 9.000000e-01_pr)*exp(-Tloc/(2.500000e+03_pr)) + (9.000000e-01_pr)*exp(-Tloc/(1.300000e+03_pr)))&
              + exp(-(1.000000e+99_pr)/Tloc)
    k(r80b) = getlindratecoeff(Tloc, k_0(FOr80b), k_inf(FOr80b),FC(FOr80b), M(mM80),Ploc)
    k_0(FOr81b) =(1.329140e+32_pr)*exp((-3.837720e+05_pr)*R_T_inv + (-4.543029e+00_pr)*T_log )
    k_inf(FOr81b) =(3.759567e+21_pr)*exp((-3.803967e+05_pr)*R_T_inv + (-1.483029e+00_pr)*T_log )
    FC(FOr81b) = ((1.0_pr - 0.000000e+00_pr)*exp(-Tloc/(5.700000e+02_pr)) + (0.000000e+00_pr)*exp(-Tloc/(1.000000e+30_pr)))&
              + exp(-(1.000000e+30_pr)/Tloc)
    k(r81b) = getlindratecoeff(Tloc, k_0(FOr81b), k_inf(FOr81b),FC(FOr81b), M(mM81),Ploc)
    k_0(FOr82b) =(1.235866e+37_pr)*exp((-4.481777e+05_pr)*R_T_inv + (-6.975576e+00_pr)*T_log )
    k_inf(FOr82b) =(3.235608e+19_pr)*exp((-4.268184e+05_pr)*R_T_inv + (-8.855764e-01_pr)*T_log )
    FC(FOr82b) = ((1.0_pr - 8.420000e-01_pr)*exp(-Tloc/(1.250000e+02_pr)) + (8.420000e-01_pr)*exp(-Tloc/(2.219000e+03_pr)))&
              + exp(-(6.882000e+03_pr)/Tloc)
    k(r82b) = getlindratecoeff(Tloc, k_0(FOr82b), k_inf(FOr82b),FC(FOr82b), M(mM82),Ploc)
    k(r83b) = (4.960139e-03_pr)*exp((-3.075113e+04_pr)*R_T_inv + (2.667816e+00_pr)*T_log )
    k(r84b) = (3.261682e-01_pr)*exp((-4.405330e+04_pr)*R_T_inv + (2.179706e+00_pr)*T_log )
    k(r85b) = (1.463783e-01_pr)*exp((-7.833637e+04_pr)*R_T_inv + (2.219164e+00_pr)*T_log )
    k(r86b) = (9.834669e-11_pr)*exp((-3.140174e+04_pr)*R_T_inv + (4.900117e+00_pr)*T_log )
    k_0(FOr87b) =(1.283786e+33_pr)*exp((-1.730795e+05_pr)*R_T_inv + (-6.614922e+00_pr)*T_log )
    k_inf(FOr87b) =(8.651087e+08_pr)*exp((-1.546114e+05_pr)*R_T_inv + (1.490078e+00_pr)*T_log )
    FC(FOr87b) = ((1.0_pr - -5.690000e-01_pr)*exp(-Tloc/(2.990000e+02_pr)) + (-5.690000e-01_pr)*exp(-Tloc/(-9.147000e+03_pr)))&
              + exp(-(1.524000e+02_pr)/Tloc)
    k(r87b) = getlindratecoeff(Tloc, k_0(FOr87b), k_inf(FOr87b),FC(FOr87b), M(mM87),Ploc)
    k(r88b) = (8.241729e+12_pr)*exp((-1.540782e+04_pr)*R_T_inv + (-1.259453e+00_pr)*T_log )
    k(r89b) = (1.263947e+01_pr)*exp((-5.187963e+04_pr)*R_T_inv + (1.187362e+00_pr)*T_log )
    k(r90b) = (9.321839e-02_pr)*exp((-2.594206e+04_pr)*R_T_inv + (2.255623e+00_pr)*T_log )
    k(r91b) = (1.429782e-04_pr)*exp((-4.284270e+04_pr)*R_T_inv + (3.110081e+00_pr)*T_log )
    k(r92b) = (1.121157e-04_pr)*exp((-4.047394e+04_pr)*R_T_inv + (3.173034e+00_pr)*T_log )
    k(r93b) = (1.480453e-03_pr)*exp((-1.112817e+05_pr)*R_T_inv + (2.396082e+00_pr)*T_log )
    k(r94b) = (2.604988e+12_pr)*exp((-2.540396e+05_pr)*R_T_inv + (-9.248394e-01_pr)*T_log )
    k(r95b) = (9.882494e+27_pr)*exp((-4.124182e+05_pr)*R_T_inv + (-6.898617e+00_pr)*T_log )
    k(r96b) = (2.200936e+08_pr)*exp((-3.656650e+05_pr)*R_T_inv + (-8.886175e-01_pr)*T_log )
    k(r99b) = (7.111666e+05_pr)*exp((-3.834759e+05_pr)*R_T_inv + (-4.853096e-01_pr)*T_log )
    k(r100b) = (1.423517e+12_pr)*exp((-2.739036e+05_pr)*R_T_inv + (-2.529494e-01_pr)*T_log )
    k(r101b) = (1.246874e+02_pr)*exp((-1.712625e+05_pr)*R_T_inv + (2.204929e+00_pr)*T_log )
    k(r102b) = (9.626968e+01_pr)*exp((-2.788915e+05_pr)*R_T_inv + (9.723681e-01_pr)*T_log )
    k(r105b) = (4.671065e+08_pr)*exp((-7.503555e+05_pr)*R_T_inv + (1.389133e-01_pr)*T_log )
    k(r106b) = (1.973761e+11_pr)*exp((-3.225834e+05_pr)*R_T_inv + (-4.234966e-01_pr)*T_log )
    k(r107b) = (1.366703e+03_pr)*exp((-3.551936e+05_pr)*R_T_inv + (-3.252930e-01_pr)*T_log )
    k(r108b) = (5.055903e+07_pr)*exp((-6.056797e+04_pr)*R_T_inv + (-2.975174e-01_pr)*T_log )
    k(r109b) = (9.411546e+04_pr)*exp((-1.920498e+05_pr)*R_T_inv + (2.526274e-01_pr)*T_log )
    k(r116b) = (8.669342e+07_pr)*exp((-1.110774e+05_pr)*R_T_inv + (7.427599e-02_pr)*T_log )
    k(r117b) = (2.400132e+09_pr)*exp((-2.995616e+05_pr)*R_T_inv + (-2.112206e-01_pr)*T_log )
    k(r118b) = (5.487816e+11_pr)*exp((-7.365690e+04_pr)*R_T_inv + (-8.744035e-01_pr)*T_log )
    k(r119b) = (1.356091e+02_pr)*exp((-1.632316e+05_pr)*R_T_inv + (1.853734e+00_pr)*T_log )
    k(r120b) = (6.960099e+08_pr)*exp((-3.057510e+05_pr)*R_T_inv + (-1.993309e-01_pr)*T_log )
    k(r121b) = (3.001774e+08_pr)*exp((-2.532180e+05_pr)*R_T_inv + (-1.253831e+00_pr)*T_log )
    k(r122b) = (6.171874e+06_pr)*exp((-4.098379e+05_pr)*R_T_inv + (9.381602e-02_pr)*T_log )
    k(r123b) = (3.704061e+14_pr)*exp((-1.530077e+05_pr)*R_T_inv + (-1.448680e+00_pr)*T_log )
    k(r124b) = (7.952135e+08_pr)*exp((-2.019065e+05_pr)*R_T_inv + (-2.736069e-01_pr)*T_log )
    k(r125b) = (1.104805e+03_pr)*exp((-1.590356e+05_pr)*R_T_inv + (1.063783e+00_pr)*T_log )
    k(r126b) = (8.017839e+07_pr)*exp((-3.208938e+05_pr)*R_T_inv + (1.034297e-01_pr)*T_log )
    k(r127b) = (3.070011e+03_pr)*exp((-3.308966e+04_pr)*R_T_inv + (-2.829556e-02_pr)*T_log )
    k(r128b) = (4.556481e+13_pr)*exp((-2.016122e+05_pr)*R_T_inv + (-1.193552e+00_pr)*T_log )
    k(r129b) = (6.060014e+04_pr)*exp((-4.596444e+04_pr)*R_T_inv + (5.661281e-01_pr)*T_log )
    k(r130b) = (1.065947e+09_pr)*exp((-2.368719e+05_pr)*R_T_inv + (-3.288551e-01_pr)*T_log )
    k(r131b) = (6.566552e+07_pr)*exp((-3.035686e+04_pr)*R_T_inv + (-2.325011e-01_pr)*T_log )
    k_0(FOr132b) =(2.091027e+22_pr)*exp((-3.127540e+05_pr)*R_T_inv + (-3.355450e+00_pr)*T_log )
    k_inf(FOr132b) =(5.759183e+18_pr)*exp((-3.062688e+05_pr)*R_T_inv + (-1.235450e+00_pr)*T_log )
    FC(FOr132b) = ((1.0_pr - 7.500000e-01_pr)*exp(-Tloc/(1.000000e+03_pr)) + (7.500000e-01_pr)*exp(-Tloc/(1.000000e+05_pr)))&
              + exp(-(1.000000e+30_pr)/Tloc)
    k(r132b) = getlindratecoeff(Tloc, k_0(FOr132b), k_inf(FOr132b),FC(FOr132b), M(mM132),Ploc)
    k(r133b) = (1.515975e+07_pr)*exp((-1.363572e+05_pr)*R_T_inv + (1.811896e-01_pr)*T_log )
    k_0(FOr134b) =(8.748476e+08_pr)*exp((-1.943686e+05_pr)*R_T_inv + (2.910567e-01_pr)*T_log )
    k_inf(FOr134b) =(5.467798e+15_pr)*exp((-2.008538e+05_pr)*R_T_inv + (-3.249433e-01_pr)*T_log )
    FC(FOr134b) = ((1.0_pr - 8.200000e-01_pr)*exp(-Tloc/(1.000000e-30_pr)) + (8.200000e-01_pr)*exp(-Tloc/(1.000000e+30_pr)))&
              + exp(-(1.000000e+30_pr)/Tloc)
    k(r134b) = getlindratecoeff(Tloc, k_0(FOr134b), k_inf(FOr134b),FC(FOr134b), M(mM134),Ploc)
    k(r135b) = (4.677526e+04_pr)*exp((-2.334079e+05_pr)*R_T_inv + (9.190726e-01_pr)*T_log )
    k(r136b) = (5.451273e+05_pr)*exp((-2.257123e+05_pr)*R_T_inv + (2.871829e-01_pr)*T_log )
    k(r137b) = (3.401897e+06_pr)*exp((-6.949171e+04_pr)*R_T_inv + (-6.176784e-04_pr)*T_log )
    k(r138b) = (1.215796e+10_pr)*exp((-2.040675e+05_pr)*R_T_inv + (-5.992763e-01_pr)*T_log )
    k(r139b) = (4.437937e+05_pr)*exp((-2.387015e+05_pr)*R_T_inv + (9.594836e-01_pr)*T_log )
    k(r140b) = (3.917383e+00_pr)*exp((-1.158707e+05_pr)*R_T_inv + (1.697690e+00_pr)*T_log )
    k(r141b) = (1.762817e+04_pr)*exp((-1.893685e+05_pr)*R_T_inv + (5.203003e-01_pr)*T_log )
    k(r142b) = (1.654593e-06_pr)*exp((6.994970e+03_pr)*R_T_inv + (1.005751e+00_pr)*T_log )
    k(r143b) = (3.476869e+02_pr)*exp((-1.619994e+05_pr)*R_T_inv + (-1.409205e-01_pr)*T_log )
    k(r144b) = (2.628322e+07_pr)*exp((-6.725848e+04_pr)*R_T_inv + (-9.877057e-02_pr)*T_log )
    k(r145b) = (5.101378e+05_pr)*exp((-1.640814e+05_pr)*R_T_inv + (2.469428e-02_pr)*T_log )
    k(r146b) = (5.044230e+04_pr)*exp((-1.406625e+04_pr)*R_T_inv + (7.289434e-01_pr)*T_log )
    k(r147b) = (1.102648e+02_pr)*exp((-1.013362e+05_pr)*R_T_inv + (1.910515e+00_pr)*T_log )
    k(r148b) = (6.776472e+08_pr)*exp((-3.256552e+05_pr)*R_T_inv + (-1.205149e-01_pr)*T_log )
    k(r149b) = (2.814801e+13_pr)*exp((-1.341286e+05_pr)*R_T_inv + (-1.256366e+00_pr)*T_log )
    k(r150b) = (1.085151e+11_pr)*exp((-4.574948e+05_pr)*R_T_inv + (-1.876732e+00_pr)*T_log )
    k(r151b) = (1.765449e+10_pr)*exp((-6.231607e+04_pr)*R_T_inv + (-9.189763e-01_pr)*T_log )
    k(r152b) = (2.655186e+02_pr)*exp((-9.805551e+04_pr)*R_T_inv + (1.253465e+00_pr)*T_log )
    k(r153b) = (6.249812e+13_pr)*exp((-6.166944e+05_pr)*R_T_inv + (-1.645463e+00_pr)*T_log )
    k(r154b) = (4.864366e+11_pr)*exp((-2.509126e+05_pr)*R_T_inv + (-1.184215e+00_pr)*T_log )
    k(r155b) = (1.389680e+05_pr)*exp((-4.371609e+05_pr)*R_T_inv + (1.687523e-01_pr)*T_log )
    k(r156b) = (2.585269e+26_pr)*exp((-2.714004e+04_pr)*R_T_inv + (-6.737674e+00_pr)*T_log )
    k(r157b) = (1.821494e+02_pr)*exp((-3.218068e+05_pr)*R_T_inv + (1.606455e+00_pr)*T_log )
    k(r158b) = (6.356047e+01_pr)*exp((-3.156174e+05_pr)*R_T_inv + (1.594565e+00_pr)*T_log )
    k(r159b) = (3.054040e+05_pr)*exp((-2.806683e+05_pr)*R_T_inv + (3.449086e-01_pr)*T_log )
    k(r160b) = (4.235279e+00_pr)*exp((-1.099335e+05_pr)*R_T_inv + (8.211366e-01_pr)*T_log )
    k(r161b) = (2.779262e+10_pr)*exp((-1.654096e+05_pr)*R_T_inv + (-7.094825e-01_pr)*T_log )
    k(r162b) = (3.567180e+03_pr)*exp((-1.134004e+04_pr)*R_T_inv + (6.241244e-01_pr)*T_log )
    k(r163b) = (1.478667e+11_pr)*exp((-5.180535e+05_pr)*R_T_inv + (-6.100570e-01_pr)*T_log )
    k(r164b) = (4.083591e+07_pr)*exp((6.540588e+03_pr)*R_T_inv + (-7.097265e-02_pr)*T_log )
    k(r165b) = (2.949008e+08_pr)*exp((-1.198809e+05_pr)*R_T_inv + (-2.775430e-01_pr)*T_log )
    k(r166b) = (1.340641e+08_pr)*exp((-4.455361e+05_pr)*R_T_inv + (7.194208e-02_pr)*T_log )
    k(r167b) = (6.933237e+10_pr)*exp((-3.101308e+05_pr)*R_T_inv + (-4.915575e-01_pr)*T_log )
    k(r168b) = (9.048053e+12_pr)*exp((-3.447168e+05_pr)*R_T_inv + (-1.070328e+00_pr)*T_log )
    k(r169b) = (1.128807e+09_pr)*exp((-1.741739e+05_pr)*R_T_inv + (-2.228494e-01_pr)*T_log )
    k(r170b) = (9.175935e+06_pr)*exp((-4.385883e+05_pr)*R_T_inv + (1.831368e-01_pr)*T_log )
    k(r171b) = (3.052116e+10_pr)*exp((-3.193063e+05_pr)*R_T_inv + (-1.026450e+00_pr)*T_log )
    k(r172b) = (2.280079e+04_pr)*exp((-1.399825e+04_pr)*R_T_inv + (9.889847e-01_pr)*T_log )
    k(r173b) = (1.437582e+10_pr)*exp((-6.536845e+04_pr)*R_T_inv + (-1.049863e+00_pr)*T_log )
    k(r174b) = (6.958218e+16_pr)*exp((-3.713692e+05_pr)*R_T_inv + (-3.293108e+00_pr)*T_log )
    k(r175b) = (9.658732e-01_pr)*exp((-8.618928e+04_pr)*R_T_inv + (2.050103e+00_pr)*T_log )
    k_0(FOr176b) =(7.706558e-03_pr)*exp((-7.173106e+04_pr)*R_T_inv + (8.912562e-01_pr)*T_log )
    k_inf(FOr176b) =(1.267358e+00_pr)*exp((-7.364315e+04_pr)*R_T_inv + (8.912561e-01_pr)*T_log )
    redP = abs(k_0(FOr176b)) * M(mM176) / max(abs(k_inf(FOr176b)), tiny(1.0_pr)) + tiny(1.0_pr)
    k(r176b) = k_inf(FOr176b) * redP / ( 1.0_pr + redP )
    k(r177b) = (2.810400e-02_pr)*exp((-2.769887e+05_pr)*R_T_inv + (1.263496e+00_pr)*T_log )
    k(r178b) = (5.554151e+02_pr)*exp((-3.336819e+05_pr)*R_T_inv + (1.263496e+00_pr)*T_log )
    k(r179b) = (1.103035e+03_pr)*exp((-2.569530e+05_pr)*R_T_inv + (8.864592e-01_pr)*T_log )
    k(r180b) = (2.601374e+04_pr)*exp((-4.452541e+05_pr)*R_T_inv + (9.261060e-01_pr)*T_log )
    k(r181b) = (1.822328e-11_pr)*exp((-2.582560e+05_pr)*R_T_inv + (5.358307e+00_pr)*T_log )
    k(r182b) = (1.752376e+08_pr)*exp((-4.769927e+04_pr)*R_T_inv + (-5.581471e-01_pr)*T_log )
    k(r183b) = (1.082833e+08_pr)*exp((-6.995336e+04_pr)*R_T_inv + (-5.057314e-01_pr)*T_log )
    k_0(FOr185b) =(8.374998e-03_pr)*exp((8.880941e+04_pr)*R_T_inv + (1.110736e+00_pr)*T_log )
    k_inf(FOr185b) =(1.183135e+03_pr)*exp((1.977341e+04_pr)*R_T_inv + (1.110736e+00_pr)*T_log )
    FC(FOr185b) = ((1.0_pr - 1.830000e-01_pr)*exp(-Tloc/(1.000000e-30_pr)) + (1.830000e-01_pr)*exp(-Tloc/(1.000000e+30_pr)))
    k(r185b) = getlindratecoeff(Tloc, k_0(FOr185b), k_inf(FOr185b),FC(FOr185b), M(mM185),Ploc)
    k(r186b) = (1.497463e+06_pr)*exp((-1.127159e+05_pr)*R_T_inv + (5.788174e-02_pr)*T_log )
    k(r187b) = (5.455061e+08_pr)*exp((-1.007507e+04_pr)*R_T_inv + (-3.375484e-01_pr)*T_log )
    k(r188b) = (1.829921e+05_pr)*exp((-9.233655e+04_pr)*R_T_inv + (8.645612e-01_pr)*T_log )
    k(r189b) = (6.951088e+02_pr)*exp((-1.672075e+05_pr)*R_T_inv + (1.268550e+00_pr)*T_log )
    k(r190b) = (3.991015e+02_pr)*exp((-5.392598e+04_pr)*R_T_inv + (-1.382956e-01_pr)*T_log )
    k(r191b) = (6.939452e+02_pr)*exp((-2.776903e+05_pr)*R_T_inv + (1.030954e+00_pr)*T_log )
    k(r192b) = (3.196722e+06_pr)*exp((-4.587478e+05_pr)*R_T_inv + (4.889441e-01_pr)*T_log )
  
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
    w(r4f) = k(r4f) * c(sH) * c(sO2) 
    w(r5f) = k(r5f) * c(sH) * c(sOH) * m(mM5)
    w(r6f) = k(r6f) * c(sH2O) * c(sO) 
    w(r7f) = k(r7f) * c(sH) * c(sO) * m(mM7)
    w(r8f) = k(r8f) * cqss(sqssH2O2) 
    w(r9f) = k(r9f) * c(sH) * cqss(sqssH2O2) 
    w(r10f) = k(r10f) * cqss(sqssH2O2) * c(sOH) 
    w(r11f) = k(r11f) * c(sH) * c(sHO2) 
    w(r12f) = k(r12f) * c(sH) * c(sHO2) 
    w(r13f) = k(r13f) * c(sHO2) * c(sO) 
    w(r14f) = k(r14f) * c(sHO2) * c(sOH) 
    w(r15f) = k(r15f) * c(sHO2) * c(sOH) 
    w(r16f) = k(r16f) * c(sHO2)**2.0_pr 
    w(r17f) = k(r17f) * c(sHO2)**2.0_pr 
    w(r18f) = k(r18f) * c(sH) * c(sO2) 
    w(r19f) = k(r19f) * c(sCO) * c(sO) 
    w(r20f) = k(r20f) * c(sCO) * c(sOH) 
    w(r21f) = k(r21f) * c(sCO) * c(sOH) 
    w(r22f) = k(r22f) * c(sCO) * c(sHO2) 
    w(r23f) = k(r23f) * c(sCH3) * c(sH) 
    w(r24f) = k(r24f) * c(sCH4) * c(sH) 
    w(r25f) = k(r25f) * c(sCH4) * c(sO) 
    w(r26f) = k(r26f) * c(sCH4) * c(sOH) 
    w(r27f) = k(r27f) * c(sCH4) * c(sHO2) 
    w(r28f) = k(r28f) * c(sCH3) * c(sHO2) 
    w(r29f) = k(r29f) * cqss(sqssCH2GSG) * c(sN2) 
    w(r30f) = k(r30f) * cqss(sqssCH2GSG) * c(sH2O) 
    w(r31f) = k(r31f) * cqss(sqssCH2GSG) * c(sO2) 
    w(r32f) = k(r32f) * cqss(sqssCH2GSG) * c(sO2) 
    w(r33f) = k(r33f) * cqss(sqssCH2GSG) * c(sO) 
    w(r34f) = k(r34f) * cqss(sqssCH2GSG) * c(sO) 
    w(r35f) = k(r35f) * cqss(sqssCH2GSG) * c(sH2) 
    w(r36f) = k(r36f) * cqss(sqssCH2GSG) * c(sH) 
    w(r37f) = k(r37f) * cqss(sqssCH2GSG) * c(sOH) 
    w(r38f) = k(r38f) * cqss(sqssCH2GSG) * c(sCO2) 
    w(r39f) = k(r39f) * cqss(sqssCH2) * c(sO2) 
    w(r40f) = k(r40f) * cqss(sqssCH2) * c(sO2) 
    w(r41f) = k(r41f) * cqss(sqssCH2) * c(sO) 
    w(r42f) = k(r42f) * cqss(sqssCH2) * c(sH) 
    w(r43f) = k(r43f) * cqss(sqssCH2) * c(sOH) 
    w(r44f) = k(r44f) * cqss(sqssCH) * c(sO2) 
    w(r45f) = k(r45f) * cqss(sqssCH) * c(sO) 
    w(r46f) = k(r46f) * cqss(sqssCH) * c(sH) 
    w(r47f) = k(r47f) * cqss(sqssCH) * c(sOH) 
    w(r48f) = k(r48f) * cqss(sqssCH) * c(sH2O) 
    w(r49f) = k(r49f) * cqss(sqssC) * c(sOH) 
    w(r50f) = k(r50f) * cqss(sqssC) * c(sO2) 
    w(r51f) = k(r51f) * c(sCH3) * c(sO2) 
    w(r52f) = k(r52f) * c(sCH3) * c(sO2) 
    w(r53f) = k(r53f) * c(sCH3) * c(sO2) 
    w(r54f) = k(r54f) * c(sCH3) * c(sO) 
    w(r55f) = k(r55f) * c(sCH3) * c(sOH) 
    w(r56f) = k(r56f) * c(sCH3) * c(sOH) 
    w(r57f) = k(r57f) * c(sCH3) * c(sOH) 
    w(r58f) = k(r58f) * c(sCH3) * c(sHO2) 
    w(r59f) = k(r59f) * cqss(sqssCH3O2) * c(sO) 
    w(r60f) = k(r60f) * cqss(sqssCH3O2) * c(sH) 
    w(r61f) = k(r61f) * cqss(sqssCH3O2) * c(sOH) 
    w(r62f) = k(r62f) * c(sCH3OH) 
    w(r63f) = k(r63f) * c(sCH3OH) * c(sOH) 
    w(r64f) = k(r64f) * c(sCH3OH) * c(sO2) 
    w(r65f) = k(r65f) * cqss(sqssCH3O) * c(sO2) 
    w(r66f) = k(r66f) * cqss(sqssCH3O) * c(sH) 
    w(r67f) = k(r67f) * c(sCH3) * cqss(sqssCH3O) 
    w(r68f) = k(r68f) * c(sCH2O) * c(sO2) 
    w(r69f) = k(r69f) * c(sCH2O) * c(sO) 
    w(r70f) = k(r70f) * c(sCH2O) * c(sH) 
    w(r71f) = k(r71f) * c(sCH2O) * c(sOH) 
    w(r72f) = k(r72f) * c(sCH2O) * c(sCH3) 
    w(r73f) = k(r73f) * cqss(sqssHCO) * m(mM73)
    w(r74f) = k(r74f) * cqss(sqssHCO) * c(sO2) 
    w(r75f) = k(r75f) * cqss(sqssHCO) * c(sO) 
    w(r76f) = k(r76f) * c(sH) * cqss(sqssHCO) 
    w(r77f) = k(r77f) * cqss(sqssHCO) * c(sOH) 
    w(r78f) = k(r78f) * c(sCH3) * cqss(sqssHCO) 
    w(r79f) = k(r79f) * cqss(sqssHCO) * c(sO) 
    w(r80f) = k(r80f) * cqss(sqssCH3O) 
    w(r81f) = k(r81f) * c(sCH3)**2.0_pr 
    w(r82f) = k(r82f) * cqss(sqssC2H5) * c(sH) 
    w(r83f) = k(r83f) * cqss(sqssC2H6) * c(sO) 
    w(r84f) = k(r84f) * cqss(sqssC2H6) * c(sH) 
    w(r85f) = k(r85f) * cqss(sqssC2H6) * c(sOH) 
    w(r86f) = k(r86f) * cqss(sqssC2H6) * c(sCH3) 
    w(r87f) = k(r87f) * c(sC2H4) * c(sH) 
    w(r88f) = k(r88f) * c(sCH3)**2.0_pr 
    w(r89f) = k(r89f) * cqss(sqssC2H5) * c(sO2) 
    w(r90f) = k(r90f) * c(sC2H4) * c(sH) 
    w(r91f) = k(r91f) * c(sC2H4) * c(sOH) 
    w(r92f) = k(r92f) * c(sC2H4) * c(sCH3) 
    w(r93f) = k(r93f) * c(sC2H4) * c(sO) 
    w(r94f) = k(r94f) * cqss(sqssCH) * c(sCH4) 
    w(r95f) = k(r95f) * cqss(sqssC2H3) * c(sO2) 
    w(r96f) = k(r96f) * cqss(sqssC2H3) * c(sO2) 
    w(r97f) = k(r97f) * cqss(sqssC2H3) * c(sO2) 
    w(r98f) = k(r98f) * cqss(sqssC2H3) * c(sO2) 
    w(r99f) = k(r99f) * cqss(sqssC2H3) * c(sO2) 
    w(r100f) = k(r100f) * c(sO) * c(sOH) * m(mM100)
    w(r101f) = k(r101f) * cqss(sqssCH) * c(sOH) 
    w(r102f) = k(r102f) * cqss(sqssCH3O2) 
    w(r103f) = k(r103f) * cqss(sqssCH3O2) * c(sOH) 
    w(r104f) = k(r104f) * cqss(sqssCH3O2) * c(sHO2) 
    w(r105f) = k(r105f) * cqss(sqssCH2) * c(sO) 
    w(r106f) = k(r106f) * cqss(sqssCH2) * c(sOH) 
    w(r107f) = k(r107f) * cqss(sqssCH2GSG) * c(sO) 
    w(r108f) = k(r108f) * cqss(sqssCH2GSG) * c(sCH4) 
    w(r109f) = k(r109f) * cqss(sqssC2H6) 
    w(r110f) = k(r110f) * c(sCH2O) * c(sO) 
    w(r111f) = k(r111f) * c(sCH2O) * c(sOH) 
    w(r112f) = k(r112f) * c(sC2H4) * c(sO2) 
    w(r113f) = k(r113f) * c(sCH3) * c(sO) * m(mM113)
    w(r114f) = k(r114f) * cqss(sqssCH3O) * c(sOH) 
    w(r115f) = k(r115f) * c(sC2H4) * c(sO) 
    w(r116f) = k(r116f) * c(sH) * cqss(sqssNH) 
    w(r117f) = k(r117f) * cqss(sqssNH) * c(sO) 
    w(r118f) = k(r118f) * cqss(sqssNH) * c(sOH) 
    w(r119f) = k(r119f) * cqss(sqssNH) * c(sOH) 
    w(r120f) = k(r120f) * cqss(sqssNH) * c(sOH) 
    w(r121f) = k(r121f) * cqss(sqssNH) * c(sO2) 
    w(r122f) = k(r122f) * cqss(sqssNH) * c(sNO) 
    w(r123f) = k(r123f) * cqss(sqssNH) * c(sNO) 
    w(r124f) = k(r124f) * c(sN) * c(sOH) 
    w(r125f) = k(r125f) * c(sN) * c(sO2) 
    w(r126f) = k(r126f) * c(sN) * c(sNO) 
    w(r127f) = k(r127f) * cqss(sqssNNH) 
    w(r128f) = k(r128f) * cqss(sqssNNH) * c(sO) 
    w(r129f) = k(r129f) * cqss(sqssNNH) * c(sO) 
    w(r130f) = k(r130f) * cqss(sqssNNH) * c(sO2) 
    w(r131f) = k(r131f) * c(sHO2) * c(sNO) 
    w(r132f) = k(r132f) * c(sNO) * c(sO) 
    w(r133f) = k(r133f) * cqss(sqssHCO) * c(sNO) 
    w(r134f) = k(r134f) * c(sH) * c(sNO) 
    w(r135f) = k(r135f) * c(sH) * cqss(sqssHNO) 
    w(r136f) = k(r136f) * cqss(sqssHNO) * c(sO) 
    w(r137f) = k(r137f) * cqss(sqssHNO) * c(sO2) 
    w(r138f) = k(r138f) * cqss(sqssHNO) * c(sNO) 
    w(r139f) = k(r139f) * c(sCH3) * cqss(sqssHNO) 
    w(r140f) = k(r140f) * c(sH) * c(sNO2) 
    w(r141f) = k(r141f) * c(sNO2) * c(sO) 
    w(r142f) = k(r142f) * c(sNO2)**2.0_pr 
    w(r143f) = k(r143f) * cqss(sqssHCO) * c(sNO2) 
    w(r144f) = k(r144f) * c(sHCN) * c(sO) 
    w(r145f) = k(r145f) * c(sHCN) * c(sO) 
    w(r146f) = k(r146f) * c(sHCN) * c(sOH) 
    w(r147f) = k(r147f) * cqss(sqssCN) * c(sH2) 
    w(r148f) = k(r148f) * cqss(sqssCN) * c(sO) 
    w(r149f) = k(r149f) * cqss(sqssCN) * c(sOH) 
    w(r150f) = k(r150f) * cqss(sqssCN) * c(sO2) 
    w(r151f) = k(r151f) * cqss(sqssCN) * c(sO2) 
    w(r152f) = k(r152f) * c(sH) * cqss(sqssNCO) 
    w(r153f) = k(r153f) * cqss(sqssNCO) * c(sNO) 
    w(r154f) = k(r154f) * cqss(sqssNCO) * c(sNO) 
    w(r155f) = k(r155f) * c(sCO) * c(sN2O) 
    w(r156f) = k(r156f) * cqss(sqssH2CN) 
    w(r157f) = k(r157f) * c(sH) * cqss(sqssH2CN) 
    w(r158f) = k(r158f) * cqss(sqssH2CN) * c(sO) 
    w(r159f) = k(r159f) * cqss(sqssH2CN) * c(sO2) 
    w(r160f) = k(r160f) * c(sCO2) * c(sN) 
    w(r161f) = k(r161f) * c(sCH3) * c(sN) 
    w(r162f) = k(r162f) * c(sCH3) * c(sNO) 
    w(r163f) = k(r163f) * cqss(sqssCH2) * c(sN) 
    w(r164f) = k(r164f) * cqss(sqssC) * c(sN2) 
    w(r165f) = k(r165f) * cqss(sqssC) * c(sNO) 
    w(r166f) = k(r166f) * cqss(sqssC) * c(sNO) 
    w(r167f) = k(r167f) * cqss(sqssCH) * c(sNO) 
    w(r168f) = k(r168f) * cqss(sqssCH) * c(sNO) 
    w(r169f) = k(r169f) * cqss(sqssCH) * c(sNO) 
    w(r170f) = k(r170f) * cqss(sqssCH) * c(sNO) 
    w(r171f) = k(r171f) * cqss(sqssCH2) * c(sNO) 
    w(r172f) = k(r172f) * cqss(sqssCH2) * c(sNO) 
    w(r173f) = k(r173f) * c(sC2H4) * cqss(sqssCN) 
    w(r174f) = k(r174f) * cqss(sqssC2H3) * c(sNO) 
    w(r175f) = k(r175f) * c(sCH4) * cqss(sqssCN) 
    w(r176f) = k(r176f) * c(sN2O) 
    w(r177f) = k(r177f) * c(sH) * c(sN2O) 
    w(r178f) = k(r178f) * c(sH) * c(sN2O) 
    w(r179f) = k(r179f) * c(sN2O) * c(sO) 
    w(r180f) = k(r180f) * c(sN2O) * c(sO) 
    w(r181f) = k(r181f) * c(sN2O) * c(sOH) 
    w(r182f) = k(r182f) * cqss(sqssCH3O2) * c(sNO) 
    w(r183f) = k(r183f) * c(sCH3) * c(sNO2) 
    w(r184f) = k(r184f) * cqss(sqssCH3O2) * c(sNO2) 
    w(r185f) = k(r185f) * c(sCH3NO2) 
    w(r186f) = k(r186f) * cqss(sqssCH3O) * c(sNO) 
    w(r187f) = k(r187f) * cqss(sqssCH) * c(sN2) 
    w(r188f) = k(r188f) * c(sH) * cqss(sqssNCN) 
    w(r189f) = k(r189f) * cqss(sqssNCN) * c(sO) 
    w(r190f) = k(r190f) * cqss(sqssNNH) * m(mM190)
    w(r191f) = k(r191f) * cqss(sqssNCN) * c(sOH) 
    w(r192f) = k(r192f) * cqss(sqssNNH) * c(sO) 
    w(r1b) = k(r1b) * c(sH)**2.0_pr * m(mM1)
    w(r2b) = k(r2b) * c(sH) * c(sOH) 
    w(r3b) = k(r3b) * c(sH) * c(sH2O) 
    w(r4b) = k(r4b) * c(sO) * c(sOH) 
    w(r5b) = k(r5b) * c(sH2O) * m(mM5)
    w(r6b) = k(r6b) * c(sOH)**2.0_pr 
    w(r7b) = k(r7b) * c(sOH) * m(mM7)
    w(r8b) = k(r8b) * c(sOH)**2.0_pr 
    w(r9b) = k(r9b) * c(sH2) * c(sHO2) 
    w(r10b) = k(r10b) * c(sH2O) * c(sHO2) 
    w(r11b) = k(r11b) * c(sOH)**2.0_pr 
    w(r12b) = k(r12b) * c(sH2) * c(sO2) 
    w(r13b) = k(r13b) * c(sO2) * c(sOH) 
    w(r14b) = k(r14b) * c(sH2O) * c(sO2) 
    w(r15b) = k(r15b) * c(sH2O) * c(sO2) 
    w(r16b) = k(r16b) * cqss(sqssH2O2) * c(sO2) 
    w(r17b) = k(r17b) * cqss(sqssH2O2) * c(sO2) 
    w(r18b) = k(r18b) * c(sHO2) 
    w(r19b) = k(r19b) * c(sCO2) 
    w(r20b) = k(r20b) * c(sCO2) * c(sH) 
    w(r21b) = k(r21b) * c(sCO2) * c(sH) 
    w(r22b) = k(r22b) * c(sCO2) * c(sOH) 
    w(r23b) = k(r23b) * c(sCH4) 
    w(r24b) = k(r24b) * c(sCH3) * c(sH2) 
    w(r25b) = k(r25b) * c(sCH3) * c(sOH) 
    w(r26b) = k(r26b) * c(sCH3) * c(sH2O) 
    w(r27b) = k(r27b) * c(sCH3) * cqss(sqssH2O2) 
    w(r28b) = k(r28b) * c(sCH4) * c(sO2) 
    w(r29b) = k(r29b) * cqss(sqssCH2) * c(sN2) 
    w(r30b) = k(r30b) * cqss(sqssCH2) * c(sH2O) 
    w(r32b) = k(r32b) * c(sCO) * c(sH2O) 
    w(r33b) = k(r33b) * c(sCO) * c(sH2) 
    w(r34b) = k(r34b) * c(sH) * cqss(sqssHCO) 
    w(r35b) = k(r35b) * c(sCH3) * c(sH) 
    w(r36b) = k(r36b) * cqss(sqssCH) * c(sH2) 
    w(r37b) = k(r37b) * c(sCH2O) * c(sH) 
    w(r38b) = k(r38b) * c(sCH2O) * c(sCO) 
    w(r39b) = k(r39b) * cqss(sqssHCO) * c(sOH) 
    w(r42b) = k(r42b) * cqss(sqssCH) * c(sH2) 
    w(r43b) = k(r43b) * cqss(sqssCH) * c(sH2O) 
    w(r44b) = k(r44b) * cqss(sqssHCO) * c(sO) 
    w(r45b) = k(r45b) * c(sCO) * c(sH) 
    w(r46b) = k(r46b) * cqss(sqssC) * c(sH2) 
    w(r47b) = k(r47b) * c(sH) * cqss(sqssHCO) 
    w(r48b) = k(r48b) * c(sCH2O) * c(sH) 
    w(r49b) = k(r49b) * c(sCO) * c(sH) 
    w(r50b) = k(r50b) * c(sCO) * c(sO) 
    w(r51b) = k(r51b) * cqss(sqssCH3O2) 
    w(r52b) = k(r52b) * cqss(sqssCH3O) * c(sO) 
    w(r53b) = k(r53b) * c(sCH2O) * c(sOH) 
    w(r54b) = k(r54b) * c(sCH2O) * c(sH) 
    w(r55b) = k(r55b) * cqss(sqssCH2GSG) * c(sH2O) 
    w(r56b) = k(r56b) * cqss(sqssCH3O) * c(sH) 
    w(r57b) = k(r57b) * cqss(sqssCH2) * c(sH2O) 
    w(r58b) = k(r58b) * cqss(sqssCH3O) * c(sOH) 
    w(r59b) = k(r59b) * cqss(sqssCH3O) * c(sO2) 
    w(r60b) = k(r60b) * cqss(sqssCH3O) * c(sOH) 
    w(r61b) = k(r61b) * c(sCH3OH) * c(sO2) 
    w(r62b) = k(r62b) * c(sCH3) * c(sOH) 
    w(r63b) = k(r63b) * cqss(sqssCH3O) * c(sH2O) 
    w(r64b) = k(r64b) * cqss(sqssCH3O) * c(sHO2) 
    w(r65b) = k(r65b) * c(sCH2O) * c(sHO2) 
    w(r66b) = k(r66b) * c(sCH2O) * c(sH2) 
    w(r67b) = k(r67b) * c(sCH2O) * c(sCH4) 
    w(r68b) = k(r68b) * cqss(sqssHCO) * c(sHO2) 
    w(r69b) = k(r69b) * cqss(sqssHCO) * c(sOH) 
    w(r70b) = k(r70b) * c(sH2) * cqss(sqssHCO) 
    w(r71b) = k(r71b) * c(sH2O) * cqss(sqssHCO) 
    w(r72b) = k(r72b) * c(sCH4) * cqss(sqssHCO) 
    w(r73b) = k(r73b) * c(sCO) * c(sH) * m(mM73)
    w(r74b) = k(r74b) * c(sCO) * c(sHO2) 
    w(r75b) = k(r75b) * c(sCO) * c(sOH) 
    w(r76b) = k(r76b) * c(sCO) * c(sH2) 
    w(r77b) = k(r77b) * c(sCO) * c(sH2O) 
    w(r78b) = k(r78b) * c(sCH4) * c(sCO) 
    w(r79b) = k(r79b) * c(sCO2) * c(sH) 
    w(r80b) = k(r80b) * c(sCH2O) * c(sH) 
    w(r81b) = k(r81b) * cqss(sqssC2H6) 
    w(r82b) = k(r82b) * cqss(sqssC2H6) 
    w(r83b) = k(r83b) * cqss(sqssC2H5) * c(sOH) 
    w(r84b) = k(r84b) * cqss(sqssC2H5) * c(sH2) 
    w(r85b) = k(r85b) * cqss(sqssC2H5) * c(sH2O) 
    w(r86b) = k(r86b) * cqss(sqssC2H5) * c(sCH4) 
    w(r87b) = k(r87b) * cqss(sqssC2H5) 
    w(r88b) = k(r88b) * cqss(sqssC2H5) * c(sH) 
    w(r89b) = k(r89b) * c(sC2H4) * c(sHO2) 
    w(r90b) = k(r90b) * cqss(sqssC2H3) * c(sH2) 
    w(r91b) = k(r91b) * cqss(sqssC2H3) * c(sH2O) 
    w(r92b) = k(r92b) * cqss(sqssC2H3) * c(sCH4) 
    w(r93b) = k(r93b) * c(sCH3) * cqss(sqssHCO) 
    w(r94b) = k(r94b) * c(sC2H4) * c(sH) 
    w(r95b) = k(r95b) * c(sCH2O) * cqss(sqssHCO) 
    w(r96b) = k(r96b) * c(sCH2O) * cqss(sqssHCO) 
    w(r99b) = k(r99b) * cqss(sqssCH3O) * c(sCO) 
    w(r100b) = k(r100b) * c(sHO2) * m(mM100)
    w(r101b) = k(r101b) * cqss(sqssC) * c(sH2O) 
    w(r102b) = k(r102b) * c(sCH2O) * c(sOH) 
    w(r105b) = k(r105b) * c(sCO) * c(sH2) 
    w(r106b) = k(r106b) * c(sCH2O) * c(sH) 
    w(r107b) = k(r107b) * c(sCO) * c(sH)**2.0_pr 
    w(r108b) = k(r108b) * c(sCH3)**2.0_pr 
    w(r109b) = k(r109b) * c(sC2H4) * c(sH2) 
    w(r116b) = k(r116b) * c(sH2) * c(sN) 
    w(r117b) = k(r117b) * c(sH) * c(sNO) 
    w(r118b) = k(r118b) * c(sH) * cqss(sqssHNO) 
    w(r119b) = k(r119b) * c(sH2O) * c(sN) 
    w(r120b) = k(r120b) * c(sH2) * c(sNO) 
    w(r121b) = k(r121b) * c(sNO) * c(sOH) 
    w(r122b) = k(r122b) * c(sN2) * c(sOH) 
    w(r123b) = k(r123b) * c(sH) * c(sN2O) 
    w(r124b) = k(r124b) * c(sH) * c(sNO) 
    w(r125b) = k(r125b) * c(sNO) * c(sO) 
    w(r126b) = k(r126b) * c(sN2) * c(sO) 
    w(r127b) = k(r127b) * c(sH) * c(sN2) 
    w(r128b) = k(r128b) * c(sH) * c(sN2O) 
    w(r129b) = k(r129b) * cqss(sqssNH) * c(sNO) 
    w(r130b) = k(r130b) * c(sHO2) * c(sN2) 
    w(r131b) = k(r131b) * c(sNO2) * c(sOH) 
    w(r132b) = k(r132b) * c(sNO2) 
    w(r133b) = k(r133b) * c(sCO) * cqss(sqssHNO) 
    w(r134b) = k(r134b) * cqss(sqssHNO) 
    w(r135b) = k(r135b) * c(sH2) * c(sNO) 
    w(r136b) = k(r136b) * c(sNO) * c(sOH) 
    w(r137b) = k(r137b) * c(sHO2) * c(sNO) 
    w(r138b) = k(r138b) * c(sN2O) * c(sOH) 
    w(r139b) = k(r139b) * c(sCH4) * c(sNO) 
    w(r140b) = k(r140b) * c(sNO) * c(sOH) 
    w(r141b) = k(r141b) * c(sNO) * c(sO2) 
    w(r142b) = k(r142b) * c(sNO)**2.0_pr * c(sO2) 
    w(r143b) = k(r143b) * c(sCO2) * c(sH) * c(sNO) 
    w(r144b) = k(r144b) * c(sH) * cqss(sqssNCO) 
    w(r145b) = k(r145b) * c(sCO) * cqss(sqssNH) 
    w(r146b) = k(r146b) * cqss(sqssCN) * c(sH2O) 
    w(r147b) = k(r147b) * c(sH) * c(sHCN) 
    w(r148b) = k(r148b) * c(sCO) * c(sN) 
    w(r149b) = k(r149b) * c(sH) * cqss(sqssNCO) 
    w(r150b) = k(r150b) * c(sCO) * c(sNO) 
    w(r151b) = k(r151b) * cqss(sqssNCO) * c(sO) 
    w(r152b) = k(r152b) * c(sCO) * cqss(sqssNH) 
    w(r153b) = k(r153b) * c(sCO2) * c(sN2) 
    w(r154b) = k(r154b) * c(sCO) * c(sN2O) 
    w(r155b) = k(r155b) * c(sCO2) * c(sN2) 
    w(r156b) = k(r156b) * c(sH) * c(sHCN) 
    w(r157b) = k(r157b) * c(sH2) * c(sHCN) 
    w(r158b) = k(r158b) * c(sHCN) * c(sOH) 
    w(r159b) = k(r159b) * c(sCH2O) * c(sNO) 
    w(r160b) = k(r160b) * c(sCO) * c(sNO) 
    w(r161b) = k(r161b) * c(sH) * cqss(sqssH2CN) 
    w(r162b) = k(r162b) * cqss(sqssH2CN) * c(sOH) 
    w(r163b) = k(r163b) * c(sH) * c(sHCN) 
    w(r164b) = k(r164b) * cqss(sqssCN) * c(sN) 
    w(r165b) = k(r165b) * cqss(sqssCN) * c(sO) 
    w(r166b) = k(r166b) * c(sCO) * c(sN) 
    w(r167b) = k(r167b) * c(sHCN) * c(sO) 
    w(r168b) = k(r168b) * c(sH) * cqss(sqssNCO) 
    w(r169b) = k(r169b) * cqss(sqssHCO) * c(sN) 
    w(r170b) = k(r170b) * c(sCO) * cqss(sqssNH) 
    w(r171b) = k(r171b) * c(sHCN) * c(sOH) 
    w(r172b) = k(r172b) * cqss(sqssH2CN) * c(sO) 
    w(r173b) = k(r173b) * cqss(sqssC2H3) * c(sHCN) 
    w(r174b) = k(r174b) * c(sCH2O) * c(sHCN) 
    w(r175b) = k(r175b) * c(sCH3) * c(sHCN) 
    w(r176b) = k(r176b) * c(sN2) * c(sO) 
    w(r177b) = k(r177b) * c(sN2) * c(sOH) 
    w(r178b) = k(r178b) * c(sN2) * c(sOH) 
    w(r179b) = k(r179b) * c(sNO)**2.0_pr 
    w(r180b) = k(r180b) * c(sN2) * c(sO2) 
    w(r181b) = k(r181b) * c(sHO2) * c(sN2) 
    w(r182b) = k(r182b) * cqss(sqssCH3O) * c(sNO2) 
    w(r183b) = k(r183b) * cqss(sqssCH3O) * c(sNO) 
    w(r185b) = k(r185b) * c(sCH3) * c(sNO2) 
    w(r186b) = k(r186b) * c(sCH2O) * cqss(sqssHNO) 
    w(r187b) = k(r187b) * c(sH) * cqss(sqssNCN) 
    w(r188b) = k(r188b) * c(sHCN) * c(sN) 
    w(r189b) = k(r189b) * cqss(sqssCN) * c(sNO) 
    w(r190b) = k(r190b) * c(sH) * c(sN2) * m(mM190)
    w(r191b) = k(r191b) * c(sHCN) * c(sNO) 
    w(r192b) = k(r192b) * c(sN2) * c(sOH) 
  
    return
  end subroutine get_reaction_rates
  
  ! ----------------------------------------------- !
  ! Evaluate production rates                       !
  ! ----------------------------------------------- !
  subroutine get_production_rates(cdot,w)
    implicit none

    real(pr), dimension(nspec) :: cdot
    real(pr), dimension(nreac + nreac_reverse) :: w

    cdot(sN2) = 0.0_pr &
         + w(r122f) &
         - w(r122b) &
         + w(r126f) &
         - w(r126b) &
         + w(r127f) &
         - w(r127b) &
         + w(r130f) &
         - w(r130b) &
         + w(r153f) &
         - w(r153b) &
         + w(r155f) &
         - w(r155b) &
         - w(r164f) &
         + w(r164b) &
         + w(r176f) &
         - w(r176b) &
         + w(r177f) &
         - w(r177b) &
         + w(r178f) &
         - w(r178b) &
         + w(r180f) &
         - w(r180b) &
         + w(r181f) &
         - w(r181b) &
         - w(r187f) &
         + w(r187b) &
         + w(r190f) &
         - w(r190b) &
         + w(r192f) &
         - w(r192b) 

    cdot(sH2) = 0.0_pr &
         - w(r1f) &
         + w(r1b) &
         - w(r2f) &
         + w(r2b) &
         - w(r3f) &
         + w(r3b) &
         + w(r9f) &
         - w(r9b) &
         + w(r12f) &
         - w(r12b) &
         + w(r24f) &
         - w(r24b) &
         + w(r33f) &
         - w(r33b) &
         - w(r35f) &
         + w(r35b) &
         + w(r36f) &
         - w(r36b) &
         + w(r42f) &
         - w(r42b) &
         + w(r46f) &
         - w(r46b) &
         + w(r66f) &
         - w(r66b) &
         + w(r70f) &
         - w(r70b) &
         + w(r76f) &
         - w(r76b) &
         + w(r84f) &
         - w(r84b) &
         + w(r90f) &
         - w(r90b) &
         + w(r105f) &
         - w(r105b) &
         + w(r109f) &
         - w(r109b) &
         + w(r111f) &
         + w(r116f) &
         - w(r116b) &
         + w(r120f) &
         - w(r120b) &
         + w(r135f) &
         - w(r135b) &
         - w(r147f) &
         + w(r147b) &
         + w(r157f) &
         - w(r157b) 

    cdot(sH) = 0.0_pr &
         + 2.0_pr * w(r1f) &
         - 2.0_pr * w(r1b) &
         + w(r2f) &
         - w(r2b) &
         + w(r3f) &
         - w(r3b) &
         - w(r4f) &
         + w(r4b) &
         - w(r5f) &
         + w(r5b) &
         - w(r7f) &
         + w(r7b) &
         - w(r9f) &
         + w(r9b) &
         - w(r11f) &
         + w(r11b) &
         - w(r12f) &
         + w(r12b) &
         - w(r18f) &
         + w(r18b) &
         + w(r20f) &
         - w(r20b) &
         + w(r21f) &
         - w(r21b) &
         - w(r23f) &
         + w(r23b) &
         - w(r24f) &
         + w(r24b) &
         + w(r31f) &
         + w(r34f) &
         - w(r34b) &
         + w(r35f) &
         - w(r35b) &
         - w(r36f) &
         + w(r36b) &
         + w(r37f) &
         - w(r37b) &
         + 2.0_pr * w(r40f) &
         + 2.0_pr * w(r41f) &
         - w(r42f) &
         + w(r42b) &
         + w(r45f) &
         - w(r45b) &
         - w(r46f) &
         + w(r46b) &
         + w(r47f) &
         - w(r47b) &
         + w(r48f) &
         - w(r48b) &
         + w(r49f) &
         - w(r49b) &
         + w(r54f) &
         - w(r54b) &
         + w(r56f) &
         - w(r56b) &
         - w(r60f) &
         + w(r60b) &
         - w(r66f) &
         + w(r66b) &
         - w(r70f) &
         + w(r70b) &
         + w(r73f) &
         - w(r73b) &
         - w(r76f) &
         + w(r76b) &
         + w(r79f) &
         - w(r79b) &
         + w(r80f) &
         - w(r80b) &
         - w(r82f) &
         + w(r82b) &
         - w(r84f) &
         + w(r84b) &
         - w(r87f) &
         + w(r87b) &
         + w(r88f) &
         - w(r88b) &
         - w(r90f) &
         + w(r90b) &
         + w(r94f) &
         - w(r94b) &
         + w(r97f) &
         + w(r98f) &
         + w(r106f) &
         - w(r106b) &
         + 2.0_pr * w(r107f) &
         - 2.0_pr * w(r107b) &
         + 2.0_pr * w(r110f) &
         + w(r111f) &
         - w(r116f) &
         + w(r116b) &
         + w(r117f) &
         - w(r117b) &
         + w(r118f) &
         - w(r118b) &
         + w(r123f) &
         - w(r123b) &
         + w(r124f) &
         - w(r124b) &
         + w(r127f) &
         - w(r127b) &
         + w(r128f) &
         - w(r128b) &
         - w(r134f) &
         + w(r134b) &
         - w(r135f) &
         + w(r135b) &
         - w(r140f) &
         + w(r140b) &
         + w(r143f) &
         - w(r143b) &
         + w(r144f) &
         - w(r144b) &
         + w(r147f) &
         - w(r147b) &
         + w(r149f) &
         - w(r149b) &
         - w(r152f) &
         + w(r152b) &
         + w(r156f) &
         - w(r156b) &
         - w(r157f) &
         + w(r157b) &
         + w(r161f) &
         - w(r161b) &
         + w(r163f) &
         - w(r163b) &
         + w(r168f) &
         - w(r168b) &
         - w(r177f) &
         + w(r177b) &
         - w(r178f) &
         + w(r178b) &
         + w(r187f) &
         - w(r187b) &
         - w(r188f) &
         + w(r188b) &
         + w(r190f) &
         - w(r190b) 

    cdot(sO2) = 0.0_pr &
         - w(r4f) &
         + w(r4b) &
         + w(r12f) &
         - w(r12b) &
         + w(r13f) &
         - w(r13b) &
         + w(r14f) &
         - w(r14b) &
         + w(r15f) &
         - w(r15b) &
         + w(r16f) &
         - w(r16b) &
         + w(r17f) &
         - w(r17b) &
         - w(r18f) &
         + w(r18b) &
         + w(r28f) &
         - w(r28b) &
         - w(r31f) &
         - w(r32f) &
         + w(r32b) &
         - w(r39f) &
         + w(r39b) &
         - w(r40f) &
         - w(r44f) &
         + w(r44b) &
         - w(r50f) &
         + w(r50b) &
         - w(r51f) &
         + w(r51b) &
         - w(r52f) &
         + w(r52b) &
         - w(r53f) &
         + w(r53b) &
         + w(r59f) &
         - w(r59b) &
         + w(r61f) &
         - w(r61b) &
         - w(r64f) &
         + w(r64b) &
         - w(r65f) &
         + w(r65b) &
         - w(r68f) &
         + w(r68b) &
         - w(r74f) &
         + w(r74b) &
         - w(r89f) &
         + w(r89b) &
         - w(r95f) &
         + w(r95b) &
         - w(r96f) &
         + w(r96b) &
         - w(r97f) &
         - w(r98f) &
         - w(r99f) &
         + w(r99b) &
         + w(r104f) &
         - w(r112f) &
         - w(r121f) &
         + w(r121b) &
         - w(r125f) &
         + w(r125b) &
         - w(r130f) &
         + w(r130b) &
         - w(r137f) &
         + w(r137b) &
         + w(r141f) &
         - w(r141b) &
         + w(r142f) &
         - w(r142b) &
         - w(r150f) &
         + w(r150b) &
         - w(r151f) &
         + w(r151b) &
         - w(r159f) &
         + w(r159b) &
         + w(r180f) &
         - w(r180b) &
         + w(r184f) 

    cdot(sO) = 0.0_pr &
         - w(r2f) &
         + w(r2b) &
         + w(r4f) &
         - w(r4b) &
         - w(r6f) &
         + w(r6b) &
         - w(r7f) &
         + w(r7b) &
         - w(r13f) &
         + w(r13b) &
         - w(r19f) &
         + w(r19b) &
         - w(r25f) &
         + w(r25b) &
         - w(r33f) &
         + w(r33b) &
         - w(r34f) &
         + w(r34b) &
         - w(r41f) &
         + w(r44f) &
         - w(r44b) &
         - w(r45f) &
         + w(r45b) &
         + w(r50f) &
         - w(r50b) &
         + w(r52f) &
         - w(r52b) &
         - w(r54f) &
         + w(r54b) &
         - w(r59f) &
         + w(r59b) &
         - w(r69f) &
         + w(r69b) &
         - w(r75f) &
         + w(r75b) &
         - w(r79f) &
         + w(r79b) &
         - w(r83f) &
         + w(r83b) &
         - w(r93f) &
         + w(r93b) &
         - w(r100f) &
         + w(r100b) &
         - w(r105f) &
         + w(r105b) &
         - w(r107f) &
         + w(r107b) &
         - w(r110f) &
         - w(r113f) &
         - w(r115f) &
         - w(r117f) &
         + w(r117b) &
         + w(r125f) &
         - w(r125b) &
         + w(r126f) &
         - w(r126b) &
         - w(r128f) &
         + w(r128b) &
         - w(r129f) &
         + w(r129b) &
         - w(r132f) &
         + w(r132b) &
         - w(r136f) &
         + w(r136b) &
         - w(r141f) &
         + w(r141b) &
         - w(r144f) &
         + w(r144b) &
         - w(r145f) &
         + w(r145b) &
         - w(r148f) &
         + w(r148b) &
         + w(r151f) &
         - w(r151b) &
         - w(r158f) &
         + w(r158b) &
         + w(r165f) &
         - w(r165b) &
         + w(r167f) &
         - w(r167b) &
         + w(r172f) &
         - w(r172b) &
         + w(r176f) &
         - w(r176b) &
         - w(r179f) &
         + w(r179b) &
         - w(r180f) &
         + w(r180b) &
         - w(r189f) &
         + w(r189b) &
         - w(r192f) &
         + w(r192b) 

    cdot(sH2O) = 0.0_pr &
         + w(r3f) &
         - w(r3b) &
         + w(r5f) &
         - w(r5b) &
         - w(r6f) &
         + w(r6b) &
         + w(r10f) &
         - w(r10b) &
         + w(r14f) &
         - w(r14b) &
         + w(r15f) &
         - w(r15b) &
         + w(r26f) &
         - w(r26b) &
         + w(r32f) &
         - w(r32b) &
         + w(r43f) &
         - w(r43b) &
         - w(r48f) &
         + w(r48b) &
         + w(r55f) &
         - w(r55b) &
         + w(r57f) &
         - w(r57b) &
         + w(r63f) &
         - w(r63b) &
         + w(r71f) &
         - w(r71b) &
         + w(r77f) &
         - w(r77b) &
         + w(r85f) &
         - w(r85b) &
         + w(r91f) &
         - w(r91b) &
         + w(r101f) &
         - w(r101b) &
         + w(r104f) &
         + w(r114f) &
         + w(r119f) &
         - w(r119b) &
         + w(r146f) &
         - w(r146b) 

    cdot(sOH) = 0.0_pr &
         + w(r2f) &
         - w(r2b) &
         - w(r3f) &
         + w(r3b) &
         + w(r4f) &
         - w(r4b) &
         - w(r5f) &
         + w(r5b) &
         + 2.0_pr * w(r6f) &
         - 2.0_pr * w(r6b) &
         + w(r7f) &
         - w(r7b) &
         + 2.0_pr * w(r8f) &
         - 2.0_pr * w(r8b) &
         - w(r10f) &
         + w(r10b) &
         + 2.0_pr * w(r11f) &
         - 2.0_pr * w(r11b) &
         + w(r13f) &
         - w(r13b) &
         - w(r14f) &
         + w(r14b) &
         - w(r15f) &
         + w(r15b) &
         - w(r20f) &
         + w(r20b) &
         - w(r21f) &
         + w(r21b) &
         + w(r22f) &
         - w(r22b) &
         + w(r25f) &
         - w(r25b) &
         - w(r26f) &
         + w(r26b) &
         + w(r31f) &
         - w(r37f) &
         + w(r37b) &
         + w(r39f) &
         - w(r39b) &
         - w(r43f) &
         + w(r43b) &
         - w(r47f) &
         + w(r47b) &
         - w(r49f) &
         + w(r49b) &
         + w(r53f) &
         - w(r53b) &
         - w(r55f) &
         + w(r55b) &
         - w(r56f) &
         + w(r56b) &
         - w(r57f) &
         + w(r57b) &
         + w(r58f) &
         - w(r58b) &
         + w(r60f) &
         - w(r60b) &
         - w(r61f) &
         + w(r61b) &
         + w(r62f) &
         - w(r62b) &
         - w(r63f) &
         + w(r63b) &
         + w(r69f) &
         - w(r69b) &
         - w(r71f) &
         + w(r71b) &
         + w(r75f) &
         - w(r75b) &
         - w(r77f) &
         + w(r77b) &
         + w(r83f) &
         - w(r83b) &
         - w(r85f) &
         + w(r85b) &
         - w(r91f) &
         + w(r91b) &
         - w(r100f) &
         + w(r100b) &
         - w(r101f) &
         + w(r101b) &
         + w(r102f) &
         - w(r102b) &
         - w(r103f) &
         - w(r106f) &
         + w(r106b) &
         - w(r111f) &
         - w(r114f) &
         + w(r115f) &
         - w(r118f) &
         + w(r118b) &
         - w(r119f) &
         + w(r119b) &
         - w(r120f) &
         + w(r120b) &
         + w(r121f) &
         - w(r121b) &
         + w(r122f) &
         - w(r122b) &
         - w(r124f) &
         + w(r124b) &
         + w(r131f) &
         - w(r131b) &
         + w(r136f) &
         - w(r136b) &
         + w(r138f) &
         - w(r138b) &
         + w(r140f) &
         - w(r140b) &
         - w(r146f) &
         + w(r146b) &
         - w(r149f) &
         + w(r149b) &
         + w(r158f) &
         - w(r158b) &
         + w(r162f) &
         - w(r162b) &
         + w(r171f) &
         - w(r171b) &
         + w(r177f) &
         - w(r177b) &
         + w(r178f) &
         - w(r178b) &
         - w(r181f) &
         + w(r181b) &
         - w(r191f) &
         + w(r191b) &
         + w(r192f) &
         - w(r192b) 

    cdot(sHO2) = 0.0_pr &
         + w(r9f) &
         - w(r9b) &
         + w(r10f) &
         - w(r10b) &
         - w(r11f) &
         + w(r11b) &
         - w(r12f) &
         + w(r12b) &
         - w(r13f) &
         + w(r13b) &
         - w(r14f) &
         + w(r14b) &
         - w(r15f) &
         + w(r15b) &
         -2.0_pr * w(r16f) &
         + 2.0_pr * w(r16b) &
         -2.0_pr * w(r17f) &
         + 2.0_pr * w(r17b) &
         + w(r18f) &
         - w(r18b) &
         - w(r22f) &
         + w(r22b) &
         - w(r27f) &
         + w(r27b) &
         - w(r28f) &
         + w(r28b) &
         - w(r58f) &
         + w(r58b) &
         + w(r64f) &
         - w(r64b) &
         + w(r65f) &
         - w(r65b) &
         + w(r68f) &
         - w(r68b) &
         + w(r74f) &
         - w(r74b) &
         + w(r89f) &
         - w(r89b) &
         + w(r100f) &
         - w(r100b) &
         + w(r103f) &
         - w(r104f) &
         + w(r130f) &
         - w(r130b) &
         - w(r131f) &
         + w(r131b) &
         + w(r137f) &
         - w(r137b) &
         + w(r181f) &
         - w(r181b) 

    cdot(sCO) = 0.0_pr &
         - w(r19f) &
         + w(r19b) &
         - w(r20f) &
         + w(r20b) &
         - w(r21f) &
         + w(r21b) &
         - w(r22f) &
         + w(r22b) &
         + w(r31f) &
         + w(r32f) &
         - w(r32b) &
         + w(r33f) &
         - w(r33b) &
         + w(r38f) &
         - w(r38b) &
         + w(r41f) &
         + w(r45f) &
         - w(r45b) &
         + w(r49f) &
         - w(r49b) &
         + w(r50f) &
         - w(r50b) &
         + w(r73f) &
         - w(r73b) &
         + w(r74f) &
         - w(r74b) &
         + w(r75f) &
         - w(r75b) &
         + w(r76f) &
         - w(r76b) &
         + w(r77f) &
         - w(r77b) &
         + w(r78f) &
         - w(r78b) &
         + w(r97f) &
         + w(r98f) &
         + w(r99f) &
         - w(r99b) &
         + w(r105f) &
         - w(r105b) &
         + w(r107f) &
         - w(r107b) &
         + w(r133f) &
         - w(r133b) &
         + w(r145f) &
         - w(r145b) &
         + w(r148f) &
         - w(r148b) &
         + w(r150f) &
         - w(r150b) &
         + w(r152f) &
         - w(r152b) &
         + w(r154f) &
         - w(r154b) &
         - w(r155f) &
         + w(r155b) &
         + w(r160f) &
         - w(r160b) &
         + w(r166f) &
         - w(r166b) &
         + w(r170f) &
         - w(r170b) 

    cdot(sCO2) = 0.0_pr &
         + w(r19f) &
         - w(r19b) &
         + w(r20f) &
         - w(r20b) &
         + w(r21f) &
         - w(r21b) &
         + w(r22f) &
         - w(r22b) &
         - w(r38f) &
         + w(r38b) &
         + w(r40f) &
         + w(r79f) &
         - w(r79b) &
         + w(r110f) &
         + w(r111f) &
         + w(r143f) &
         - w(r143b) &
         + w(r153f) &
         - w(r153b) &
         + w(r155f) &
         - w(r155b) &
         - w(r160f) &
         + w(r160b) 

    cdot(sCH4) = 0.0_pr &
         + w(r23f) &
         - w(r23b) &
         - w(r24f) &
         + w(r24b) &
         - w(r25f) &
         + w(r25b) &
         - w(r26f) &
         + w(r26b) &
         - w(r27f) &
         + w(r27b) &
         + w(r28f) &
         - w(r28b) &
         + w(r67f) &
         - w(r67b) &
         + w(r72f) &
         - w(r72b) &
         + w(r78f) &
         - w(r78b) &
         + w(r86f) &
         - w(r86b) &
         + w(r92f) &
         - w(r92b) &
         - w(r94f) &
         + w(r94b) &
         - w(r108f) &
         + w(r108b) &
         + w(r139f) &
         - w(r139b) &
         - w(r175f) &
         + w(r175b) 

    cdot(sCH3) = 0.0_pr &
         - w(r23f) &
         + w(r23b) &
         + w(r24f) &
         - w(r24b) &
         + w(r25f) &
         - w(r25b) &
         + w(r26f) &
         - w(r26b) &
         + w(r27f) &
         - w(r27b) &
         - w(r28f) &
         + w(r28b) &
         + w(r35f) &
         - w(r35b) &
         - w(r51f) &
         + w(r51b) &
         - w(r52f) &
         + w(r52b) &
         - w(r53f) &
         + w(r53b) &
         - w(r54f) &
         + w(r54b) &
         - w(r55f) &
         + w(r55b) &
         - w(r56f) &
         + w(r56b) &
         - w(r57f) &
         + w(r57b) &
         - w(r58f) &
         + w(r58b) &
         + w(r62f) &
         - w(r62b) &
         - w(r67f) &
         + w(r67b) &
         - w(r72f) &
         + w(r72b) &
         - w(r78f) &
         + w(r78b) &
         -2.0_pr * w(r81f) &
         + 2.0_pr * w(r81b) &
         - w(r86f) &
         + w(r86b) &
         -2.0_pr * w(r88f) &
         + 2.0_pr * w(r88b) &
         - w(r92f) &
         + w(r92b) &
         + w(r93f) &
         - w(r93b) &
         + 2.0_pr * w(r108f) &
         - 2.0_pr * w(r108b) &
         - w(r113f) &
         - w(r139f) &
         + w(r139b) &
         - w(r161f) &
         + w(r161b) &
         - w(r162f) &
         + w(r162b) &
         + w(r175f) &
         - w(r175b) &
         - w(r183f) &
         + w(r183b) &
         + w(r185f) &
         - w(r185b) 

    cdot(sCH3OH) = 0.0_pr &
         + w(r61f) &
         - w(r61b) &
         - w(r62f) &
         + w(r62b) &
         - w(r63f) &
         + w(r63b) &
         - w(r64f) &
         + w(r64b) 

    cdot(sCH2O) = 0.0_pr &
         + w(r37f) &
         - w(r37b) &
         + w(r38f) &
         - w(r38b) &
         + w(r48f) &
         - w(r48b) &
         + w(r53f) &
         - w(r53b) &
         + w(r54f) &
         - w(r54b) &
         + w(r65f) &
         - w(r65b) &
         + w(r66f) &
         - w(r66b) &
         + w(r67f) &
         - w(r67b) &
         - w(r68f) &
         + w(r68b) &
         - w(r69f) &
         + w(r69b) &
         - w(r70f) &
         + w(r70b) &
         - w(r71f) &
         + w(r71b) &
         - w(r72f) &
         + w(r72b) &
         + w(r80f) &
         - w(r80b) &
         + w(r95f) &
         - w(r95b) &
         + w(r96f) &
         - w(r96b) &
         + w(r97f) &
         + w(r98f) &
         + w(r102f) &
         - w(r102b) &
         + w(r104f) &
         + w(r106f) &
         - w(r106b) &
         - w(r110f) &
         - w(r111f) &
         + w(r114f) &
         + w(r159f) &
         - w(r159b) &
         + w(r174f) &
         - w(r174b) &
         + w(r186f) &
         - w(r186b) 

    cdot(sC2H4) = 0.0_pr &
         - w(r87f) &
         + w(r87b) &
         + w(r89f) &
         - w(r89b) &
         - w(r90f) &
         + w(r90b) &
         - w(r91f) &
         + w(r91b) &
         - w(r92f) &
         + w(r92b) &
         - w(r93f) &
         + w(r93b) &
         + w(r94f) &
         - w(r94b) &
         + w(r109f) &
         - w(r109b) &
         - w(r112f) &
         - w(r115f) &
         - w(r173f) &
         + w(r173b) 

    cdot(sNO) = 0.0_pr &
         + w(r117f) &
         - w(r117b) &
         + w(r120f) &
         - w(r120b) &
         + w(r121f) &
         - w(r121b) &
         - w(r122f) &
         + w(r122b) &
         - w(r123f) &
         + w(r123b) &
         + w(r124f) &
         - w(r124b) &
         + w(r125f) &
         - w(r125b) &
         - w(r126f) &
         + w(r126b) &
         + w(r129f) &
         - w(r129b) &
         - w(r131f) &
         + w(r131b) &
         - w(r132f) &
         + w(r132b) &
         - w(r133f) &
         + w(r133b) &
         - w(r134f) &
         + w(r134b) &
         + w(r135f) &
         - w(r135b) &
         + w(r136f) &
         - w(r136b) &
         + w(r137f) &
         - w(r137b) &
         - w(r138f) &
         + w(r138b) &
         + w(r139f) &
         - w(r139b) &
         + w(r140f) &
         - w(r140b) &
         + w(r141f) &
         - w(r141b) &
         + 2.0_pr * w(r142f) &
         - 2.0_pr * w(r142b) &
         + w(r143f) &
         - w(r143b) &
         + w(r150f) &
         - w(r150b) &
         - w(r153f) &
         + w(r153b) &
         - w(r154f) &
         + w(r154b) &
         + w(r159f) &
         - w(r159b) &
         + w(r160f) &
         - w(r160b) &
         - w(r162f) &
         + w(r162b) &
         - w(r165f) &
         + w(r165b) &
         - w(r166f) &
         + w(r166b) &
         - w(r167f) &
         + w(r167b) &
         - w(r168f) &
         + w(r168b) &
         - w(r169f) &
         + w(r169b) &
         - w(r170f) &
         + w(r170b) &
         - w(r171f) &
         + w(r171b) &
         - w(r172f) &
         + w(r172b) &
         - w(r174f) &
         + w(r174b) &
         + 2.0_pr * w(r179f) &
         - 2.0_pr * w(r179b) &
         - w(r182f) &
         + w(r182b) &
         + w(r183f) &
         - w(r183b) &
         + w(r184f) &
         - w(r186f) &
         + w(r186b) &
         + w(r189f) &
         - w(r189b) &
         + w(r191f) &
         - w(r191b) 

    cdot(sN2O) = 0.0_pr &
         + w(r123f) &
         - w(r123b) &
         + w(r128f) &
         - w(r128b) &
         + w(r138f) &
         - w(r138b) &
         + w(r154f) &
         - w(r154b) &
         - w(r155f) &
         + w(r155b) &
         - w(r176f) &
         + w(r176b) &
         - w(r177f) &
         + w(r177b) &
         - w(r178f) &
         + w(r178b) &
         - w(r179f) &
         + w(r179b) &
         - w(r180f) &
         + w(r180b) &
         - w(r181f) &
         + w(r181b) 

    cdot(sNO2) = 0.0_pr &
         + w(r131f) &
         - w(r131b) &
         + w(r132f) &
         - w(r132b) &
         - w(r140f) &
         + w(r140b) &
         - w(r141f) &
         + w(r141b) &
         -2.0_pr * w(r142f) &
         + 2.0_pr * w(r142b) &
         - w(r143f) &
         + w(r143b) &
         + w(r182f) &
         - w(r182b) &
         - w(r183f) &
         + w(r183b) &
         - w(r184f) &
         + w(r185f) &
         - w(r185b) 

    cdot(sN) = 0.0_pr &
         + w(r116f) &
         - w(r116b) &
         + w(r119f) &
         - w(r119b) &
         - w(r124f) &
         + w(r124b) &
         - w(r125f) &
         + w(r125b) &
         - w(r126f) &
         + w(r126b) &
         + w(r148f) &
         - w(r148b) &
         - w(r160f) &
         + w(r160b) &
         - w(r161f) &
         + w(r161b) &
         - w(r163f) &
         + w(r163b) &
         + w(r164f) &
         - w(r164b) &
         + w(r166f) &
         - w(r166b) &
         + w(r169f) &
         - w(r169b) &
         + w(r188f) &
         - w(r188b) 

    cdot(sHCN) = 0.0_pr &
         - w(r144f) &
         + w(r144b) &
         - w(r145f) &
         + w(r145b) &
         - w(r146f) &
         + w(r146b) &
         + w(r147f) &
         - w(r147b) &
         + w(r156f) &
         - w(r156b) &
         + w(r157f) &
         - w(r157b) &
         + w(r158f) &
         - w(r158b) &
         + w(r163f) &
         - w(r163b) &
         + w(r167f) &
         - w(r167b) &
         + w(r171f) &
         - w(r171b) &
         + w(r173f) &
         - w(r173b) &
         + w(r174f) &
         - w(r174b) &
         + w(r175f) &
         - w(r175b) &
         + w(r188f) &
         - w(r188b) &
         + w(r191f) &
         - w(r191b) 

    cdot(sCH3NO2) = 0.0_pr &
         - w(r185f) &
         + w(r185b) 

  
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
    real(pr) :: CH2_ct
    real(pr) :: CH2_num
    real(pr) :: CH2_denom
    real(pr) :: CH2_CH2GSG
    real(pr) :: CH2_CH
    real(pr) :: CH2_HCO
    real(pr) :: CH2_H2CN
    real(pr) :: CH2GSG_ct
    real(pr) :: CH2GSG_num
    real(pr) :: CH2GSG_denom
    real(pr) :: CH2GSG_CH2
    real(pr) :: CH2GSG_CH
    real(pr) :: CH2GSG_HCO
    real(pr) :: C_ct
    real(pr) :: C_num
    real(pr) :: C_denom
    real(pr) :: C_CH
    real(pr) :: C_CN
    real(pr) :: CH_ct
    real(pr) :: CH_num
    real(pr) :: CH_denom
    real(pr) :: CH_CH2
    real(pr) :: CH_CH2GSG
    real(pr) :: CH_C
    real(pr) :: CH_HCO
    real(pr) :: CH_NH
    real(pr) :: CH_NCN
    real(pr) :: CH_NCO
    real(pr) :: CH3O2_ct
    real(pr) :: CH3O2_num
    real(pr) :: CH3O2_denom
    real(pr) :: CH3O2_CH3O
    real(pr) :: CH3O_ct
    real(pr) :: CH3O_num
    real(pr) :: CH3O_denom
    real(pr) :: CH3O_CH3O2
    real(pr) :: CH3O_C2H3
    real(pr) :: CH3O_HNO
    real(pr) :: HCO_ct
    real(pr) :: HCO_num
    real(pr) :: HCO_denom
    real(pr) :: HCO_CH2
    real(pr) :: HCO_CH2GSG
    real(pr) :: HCO_CH
    real(pr) :: HCO_C2H3
    real(pr) :: HCO_HNO
    real(pr) :: C2H6_ct
    real(pr) :: C2H6_num
    real(pr) :: C2H6_denom
    real(pr) :: C2H6_C2H5
    real(pr) :: C2H5_ct
    real(pr) :: C2H5_num
    real(pr) :: C2H5_denom
    real(pr) :: C2H5_C2H6
    real(pr) :: C2H3_ct
    real(pr) :: C2H3_num
    real(pr) :: C2H3_denom
    real(pr) :: C2H3_CH3O
    real(pr) :: C2H3_HCO
    real(pr) :: C2H3_CN
    real(pr) :: HNO_ct
    real(pr) :: HNO_num
    real(pr) :: HNO_denom
    real(pr) :: HNO_CH3O
    real(pr) :: HNO_HCO
    real(pr) :: HNO_NH
    real(pr) :: NH_ct
    real(pr) :: NH_num
    real(pr) :: NH_denom
    real(pr) :: NH_CH
    real(pr) :: NH_HNO
    real(pr) :: NH_NNH
    real(pr) :: NH_NCO
    real(pr) :: NNH_ct
    real(pr) :: NNH_num
    real(pr) :: NNH_denom
    real(pr) :: NNH_NH
    real(pr) :: CN_ct
    real(pr) :: CN_num
    real(pr) :: CN_denom
    real(pr) :: CN_C
    real(pr) :: CN_C2H3
    real(pr) :: CN_NCN
    real(pr) :: CN_NCO
    real(pr) :: NCN_ct
    real(pr) :: NCN_num
    real(pr) :: NCN_denom
    real(pr) :: NCN_CH
    real(pr) :: NCN_CN
    real(pr) :: NCO_ct
    real(pr) :: NCO_num
    real(pr) :: NCO_denom
    real(pr) :: NCO_CH
    real(pr) :: NCO_NH
    real(pr) :: NCO_CN
    real(pr) :: H2CN_ct
    real(pr) :: H2CN_num
    real(pr) :: H2CN_denom
    real(pr) :: H2CN_CH2
  
    real(pr) :: a_p_a
    real(pr) :: a_r_a
    real(pr) :: a_u_a
    real(pr) :: a_ac_a
    real(pr) :: a_ag_a
    real(pr) :: a_at_a
    real(pr) :: a_av_a
    real(pr) :: a_ay_a
    real(pr) :: a_bg_a
    real(pr) :: a_cm_a
    real(pr) :: a_co_a
    real(pr) :: a_cr_a
    real(pr) :: a_dz_a
    real(pr) :: a_dg_a
    real(pr) :: a_dv_a
    real(pr) :: a_eh_a
    real(pr) :: a_ga_a
    real(pr) :: a_gp_a
    real(pr) :: a_hc_a
    real(pr) :: a_he_a
    real(pr) :: a_hh_a
    real(pr) :: a_hp_a
    real(pr) :: a_ag_b
    real(pr) :: a_av_b
    real(pr) :: a_ay_b
    real(pr) :: a_co_b
    real(pr) :: a_cr_b
    real(pr) :: a_dg_b
    real(pr) :: a_dv_b
    real(pr) :: a_eh_b
    real(pr) :: a_ga_b
    real(pr) :: a_gp_b
    real(pr) :: a_he_b
    real(pr) :: a_hh_b
    real(pr) :: a_av_c
    real(pr) :: a_bd_c
    real(pr) :: a_co_c
    real(pr) :: a_dl_c
    real(pr) :: a_eh_c
    real(pr) :: a_fl_c
    real(pr) :: a_ft_c
    real(pr) :: a_ga_c
    real(pr) :: a_gi_c
    real(pr) :: a_gp_c
    real(pr) :: a_gx_c
    real(pr) :: a_he_c
    real(pr) :: a_cr_d
    real(pr) :: a_cu_d
    real(pr) :: a_cx_d
    real(pr) :: a_cy_d
    real(pr) :: a_dg_d
    real(pr) :: a_dv_d
    real(pr) :: a_dy_d
    real(pr) :: a_ek_d
    real(pr) :: a_en_d
    real(pr) :: a_eq_d
    real(pr) :: a_er_d
    real(pr) :: a_fc_d
    real(pr) :: a_fo_d
    real(pr) :: a_fr_d
    real(pr) :: a_fu_d
    real(pr) :: a_fv_d
    real(pr) :: a_gd_d
    real(pr) :: a_gg_d
    real(pr) :: a_gj_d
    real(pr) :: a_gk_d
    real(pr) :: a_gs_d
    real(pr) :: a_gv_d
    real(pr) :: a_gy_d
    real(pr) :: a_hz_d
    real(pr) :: a_hh_d
    real(pr) :: a_hk_d
    real(pr) :: a_hn_d
    real(pr) :: a_ho_d
    real(pr) :: a_cb_e
    real(pr) :: a_df_e
    real(pr) :: a_du_e
    real(pr) :: a_cs_f
    real(pr) :: a_ct_f
    real(pr) :: a_dh_f
    real(pr) :: a_di_f
    real(pr) :: a_dw_f
    real(pr) :: a_dx_f
    real(pr) :: a_em_f
    real(pr) :: a_fp_f
    real(pr) :: a_dh_g
    real(pr) :: a_di_g
    real(pr) :: a_dw_g
    real(pr) :: a_dx_g
    real(pr) :: a_el_g
    real(pr) :: a_em_g
    real(pr) :: a_fp_g
    real(pr) :: a_fq_g
    real(pr) :: a_ge_g
    real(pr) :: a_gf_g
    real(pr) :: a_gt_g
    real(pr) :: a_gu_g
    real(pr) :: a_hi_g
    real(pr) :: a_hj_g
    real(pr) :: a_ea_h
    real(pr) :: a_ep_h
    real(pr) :: a_ft_h
    real(pr) :: a_gi_h
    real(pr) :: a_gx_h
    real(pr) :: a_hm_h
    real(pr) :: a_en_i
    real(pr) :: a_fc_i
    real(pr) :: a_fr_i
    real(pr) :: a_gg_i
    real(pr) :: a_gv_i
    real(pr) :: a_hk_i
    real(pr) :: a_fd_j
    real(pr) :: a_fg_j
    real(pr) :: a_fs_j
    real(pr) :: a_fv_j
    real(pr) :: a_gh_j
    real(pr) :: a_gk_j
    real(pr) :: a_gw_j
    real(pr) :: a_hz_j
    real(pr) :: a_hl_j
    real(pr) :: a_ho_j
    real(pr) :: a_gj_l
    real(pr) :: a_gk_l
    real(pr) :: a_gy_l
    real(pr) :: a_hz_l
    real(pr) :: a_hn_l
    real(pr) :: a_ho_l
    real(pr) :: b_c_a
    real(pr) :: A_A_A
    real(pr) :: A_B_A
    real(pr) :: A_C_A
    real(pr) :: A_D_A
    real(pr) :: A_E_A
    real(pr) :: A_F_A
    real(pr) :: A_G_A
    real(pr) :: A_H_A
    real(pr) :: A_I_A
    real(pr) :: A_J_A
    real(pr) :: A_K_A
    real(pr) :: A_L_A
    real(pr) :: A_M_A
    real(pr) :: A_N_A
    real(pr) :: A_B_B
    real(pr) :: A_C_B
    real(pr) :: A_D_B
    real(pr) :: A_E_B
    real(pr) :: A_F_B
    real(pr) :: A_G_B
    real(pr) :: A_H_B
    real(pr) :: A_I_B
    real(pr) :: A_J_B
    real(pr) :: A_K_B
    real(pr) :: A_L_B
    real(pr) :: A_M_B
    real(pr) :: A_N_B
    real(pr) :: A_C_C
    real(pr) :: A_D_C
    real(pr) :: A_E_C
    real(pr) :: A_F_C
    real(pr) :: A_G_C
    real(pr) :: A_H_C
    real(pr) :: A_I_C
    real(pr) :: A_J_C
    real(pr) :: A_K_C
    real(pr) :: A_L_C
    real(pr) :: A_M_C
    real(pr) :: A_N_C
    real(pr) :: A_D_D
    real(pr) :: A_E_D
    real(pr) :: A_F_D
    real(pr) :: A_G_D
    real(pr) :: A_H_D
    real(pr) :: A_I_D
    real(pr) :: A_J_D
    real(pr) :: A_K_D
    real(pr) :: A_L_D
    real(pr) :: A_M_D
    real(pr) :: A_N_D
    real(pr) :: A_E_E
    real(pr) :: A_F_E
    real(pr) :: A_G_E
    real(pr) :: A_H_E
    real(pr) :: A_I_E
    real(pr) :: A_J_E
    real(pr) :: A_K_E
    real(pr) :: A_L_E
    real(pr) :: A_M_E
    real(pr) :: A_N_E
    real(pr) :: A_F_F
    real(pr) :: A_G_F
    real(pr) :: A_H_F
    real(pr) :: A_I_F
    real(pr) :: A_J_F
    real(pr) :: A_K_F
    real(pr) :: A_L_F
    real(pr) :: A_M_F
    real(pr) :: A_N_F
    real(pr) :: A_G_G
    real(pr) :: A_H_G
    real(pr) :: A_I_G
    real(pr) :: A_J_G
    real(pr) :: A_K_G
    real(pr) :: A_L_G
    real(pr) :: A_M_G
    real(pr) :: A_N_G
    real(pr) :: A_H_H
    real(pr) :: A_I_H
    real(pr) :: A_J_H
    real(pr) :: A_K_H
    real(pr) :: A_L_H
    real(pr) :: A_M_H
    real(pr) :: A_N_H
    real(pr) :: A_I_I
    real(pr) :: A_J_I
    real(pr) :: A_K_I
    real(pr) :: A_L_I
    real(pr) :: A_M_I
    real(pr) :: A_N_I
    real(pr) :: A_J_J
    real(pr) :: A_K_J
    real(pr) :: A_L_J
    real(pr) :: A_M_J
    real(pr) :: A_N_J
    real(pr) :: A_K_K
    real(pr) :: A_L_K
    real(pr) :: A_M_K
    real(pr) :: A_N_K
    real(pr) :: A_L_L
    real(pr) :: A_M_L
    real(pr) :: A_N_L
    real(pr) :: A_M_M
    real(pr) :: A_N_M
    real(pr) :: A_N_N
    real(pr) :: B_A_A

    H2O2_denom = tiny(1.0_pr) + ( 0.0_pr &
             + k(r8f)&
             + k(r9f)* c(sH) &
             + k(r10f)* c(sOH) &
             + k(r16b)* c(sO2) &
             + k(r17b)* c(sO2) &
             + k(r27b)* c(sCH3)   )

    H2O2_num = ( 0.0_pr &
             + k(r16f) *c(sHO2)** 2.0_pr&
             + k(r17f) *c(sHO2)** 2.0_pr&
             + k(r27f)* c(sCH4) * c(sHO2) &
             + k(r8b) *c(sOH)** 2.0_pr&
             + k(r9b)* c(sH2) * c(sHO2) &
             + k(r10b)* c(sH2O) * c(sHO2)   )

    H2O2_ct = H2O2_num / H2O2_denom

    cqss(sqssH2O2) = H2O2_ct  

    H2CN_denom = tiny(1.0_pr) + ( 0.0_pr &
             + k(r156f)&
             + k(r157f)* c(sH) &
             + k(r158f)* c(sO) &
             + k(r159f)* c(sO2) &
             + k(r161b)* c(sH) &
             + k(r162b)* c(sOH) &
             + k(r172b)* c(sO)   )

    H2CN_num = ( 0.0_pr &
             + k(r161f)* c(sCH3) * c(sN) &
             + k(r162f)* c(sCH3) * c(sNO) &
             + k(r156b)* c(sH) * c(sHCN) &
             + k(r157b)* c(sH2) * c(sHCN) &
             + k(r158b)* c(sHCN) * c(sOH) &
             + k(r159b)* c(sCH2O) * c(sNO)   )

    H2CN_ct = H2CN_num / H2CN_denom

    H2CN_CH2 = - ( 0.0_pr &
          + k(r172f) * c(sNO)  ) / H2CN_denom

    NCO_denom = tiny(1.0_pr) + ( 0.0_pr &
             + k(r152f)* c(sH) &
             + k(r153f)* c(sNO) &
             + k(r154f)* c(sNO) &
             + k(r144b)* c(sH) &
             + k(r149b)* c(sH) &
             + k(r151b)* c(sO) &
             + k(r168b)* c(sH)   )

    NCO_num = ( 0.0_pr &
             + k(r144f)* c(sHCN) * c(sO) &
             + k(r153b)* c(sCO2) * c(sN2) &
             + k(r154b)* c(sCO) * c(sN2O)   )

    NCO_ct = NCO_num / NCO_denom

    NCO_CH = - ( 0.0_pr &
          + k(r168f) * c(sNO)  ) / NCO_denom

    NCO_NH = - ( 0.0_pr &
          + k(r152b) * c(sCO)  ) / NCO_denom

    NCO_CN = - ( 0.0_pr &
          + k(r149f) * c(sOH) &
          + k(r151f) * c(sO2)  ) / NCO_denom

    NCN_denom = tiny(1.0_pr) + ( 0.0_pr &
             + k(r188f)* c(sH) &
             + k(r189f)* c(sO) &
             + k(r191f)* c(sOH) &
             + k(r187b)* c(sH)   )

    NCN_num = ( 0.0_pr &
             + k(r188b)* c(sHCN) * c(sN) &
             + k(r191b)* c(sHCN) * c(sNO)   )

    NCN_ct = NCN_num / NCN_denom

    NCN_CH = - ( 0.0_pr &
          + k(r187f) * c(sN2)  ) / NCN_denom

    NCN_CN = - ( 0.0_pr &
          + k(r189b) * c(sNO)  ) / NCN_denom

    CN_denom = tiny(1.0_pr) + ( 0.0_pr &
             + k(r147f)* c(sH2) &
             + k(r148f)* c(sO) &
             + k(r149f)* c(sOH) &
             + k(r150f)* c(sO2) &
             + k(r151f)* c(sO2) &
             + k(r173f)* c(sC2H4) &
             + k(r175f)* c(sCH4) &
             + k(r146b)* c(sH2O) &
             + k(r164b)* c(sN) &
             + k(r165b)* c(sO) &
             + k(r189b)* c(sNO)   )

    CN_num = ( 0.0_pr &
             + k(r146f)* c(sHCN) * c(sOH) &
             + k(r147b)* c(sH) * c(sHCN) &
             + k(r148b)* c(sCO) * c(sN) &
             + k(r150b)* c(sCO) * c(sNO) &
             + k(r175b)* c(sCH3) * c(sHCN)   )

    CN_ct = CN_num / CN_denom

    CN_C = - ( 0.0_pr &
          + k(r164f) * c(sN2) &
          + k(r165f) * c(sNO)  ) / CN_denom

    CN_C2H3 = - ( 0.0_pr &
          + k(r173b) * c(sHCN)  ) / CN_denom

    CN_NCN = - ( 0.0_pr &
          + k(r189f) * c(sO)  ) / CN_denom

    CN_NCO = - ( 0.0_pr &
          + k(r149b) * c(sH) &
          + k(r151b) * c(sO)  ) / CN_denom

    NNH_denom = tiny(1.0_pr) + ( 0.0_pr &
             + k(r127f)&
             + k(r128f)* c(sO) &
             + k(r129f)* c(sO) &
             + k(r130f)* c(sO2) &
             + k(r190f)* m(mM190) &
             + k(r192f)* c(sO)   )

    NNH_num = ( 0.0_pr &
             + k(r127b)* c(sH) * c(sN2) &
             + k(r128b)* c(sH) * c(sN2O) &
             + k(r130b)* c(sHO2) * c(sN2) &
             + k(r190b)* c(sH) * c(sN2) * m(mM190) &
             + k(r192b)* c(sN2) * c(sOH)   )

    NNH_ct = NNH_num / NNH_denom

    NNH_NH = - ( 0.0_pr &
          + k(r129b) * c(sNO)  ) / NNH_denom

    NH_denom = tiny(1.0_pr) + ( 0.0_pr &
             + k(r116f)* c(sH) &
             + k(r117f)* c(sO) &
             + k(r118f)* c(sOH) &
             + k(r119f)* c(sOH) &
             + k(r120f)* c(sOH) &
             + k(r121f)* c(sO2) &
             + k(r122f)* c(sNO) &
             + k(r123f)* c(sNO) &
             + k(r129b)* c(sNO) &
             + k(r145b)* c(sCO) &
             + k(r152b)* c(sCO) &
             + k(r170b)* c(sCO)   )

    NH_num = ( 0.0_pr &
             + k(r145f)* c(sHCN) * c(sO) &
             + k(r116b)* c(sH2) * c(sN) &
             + k(r117b)* c(sH) * c(sNO) &
             + k(r119b)* c(sH2O) * c(sN) &
             + k(r120b)* c(sH2) * c(sNO) &
             + k(r121b)* c(sNO) * c(sOH) &
             + k(r122b)* c(sN2) * c(sOH) &
             + k(r123b)* c(sH) * c(sN2O)   )

    NH_ct = NH_num / NH_denom

    NH_CH = - ( 0.0_pr &
          + k(r170f) * c(sNO)  ) / NH_denom

    NH_HNO = - ( 0.0_pr &
          + k(r118b) * c(sH)  ) / NH_denom

    NH_NNH = - ( 0.0_pr &
          + k(r129f) * c(sO)  ) / NH_denom

    NH_NCO = - ( 0.0_pr &
          + k(r152f) * c(sH)  ) / NH_denom

    HNO_denom = tiny(1.0_pr) + ( 0.0_pr &
             + k(r135f)* c(sH) &
             + k(r136f)* c(sO) &
             + k(r137f)* c(sO2) &
             + k(r138f)* c(sNO) &
             + k(r139f)* c(sCH3) &
             + k(r118b)* c(sH) &
             + k(r133b)* c(sCO) &
             + k(r134b)&
             + k(r186b)* c(sCH2O)   )

    HNO_num = ( 0.0_pr &
             + k(r134f)* c(sH) * c(sNO) &
             + k(r135b)* c(sH2) * c(sNO) &
             + k(r136b)* c(sNO) * c(sOH) &
             + k(r137b)* c(sHO2) * c(sNO) &
             + k(r138b)* c(sN2O) * c(sOH) &
             + k(r139b)* c(sCH4) * c(sNO)   )

    HNO_ct = HNO_num / HNO_denom

    HNO_CH3O = - ( 0.0_pr &
          + k(r186f) * c(sNO)  ) / HNO_denom

    HNO_HCO = - ( 0.0_pr &
          + k(r133f) * c(sNO)  ) / HNO_denom

    HNO_NH = - ( 0.0_pr &
          + k(r118f) * c(sOH)  ) / HNO_denom

    C2H3_denom = tiny(1.0_pr) + ( 0.0_pr &
             + k(r95f)* c(sO2) &
             + k(r96f)* c(sO2) &
             + k(r97f)* c(sO2) &
             + k(r98f)* c(sO2) &
             + k(r99f)* c(sO2) &
             + k(r174f)* c(sNO) &
             + k(r90b)* c(sH2) &
             + k(r91b)* c(sH2O) &
             + k(r92b)* c(sCH4) &
             + k(r173b)* c(sHCN)   )

    C2H3_num = ( 0.0_pr &
             + k(r90f)* c(sC2H4) * c(sH) &
             + k(r91f)* c(sC2H4) * c(sOH) &
             + k(r92f)* c(sC2H4) * c(sCH3) &
             + k(r115f)* c(sC2H4) * c(sO) &
             + k(r174b)* c(sCH2O) * c(sHCN)   )

    C2H3_ct = C2H3_num / C2H3_denom

    C2H3_CH3O = - ( 0.0_pr &
          + k(r99b) * c(sCO)  ) / C2H3_denom

    C2H3_HCO = - ( 0.0_pr &
          + k(r95b) * c(sCH2O) &
          + k(r96b) * c(sCH2O)  ) / C2H3_denom

    C2H3_CN = - ( 0.0_pr &
          + k(r173f) * c(sC2H4)  ) / C2H3_denom

    HCO_denom = tiny(1.0_pr) + ( 0.0_pr &
             + k(r73f)* m(mM73) &
             + k(r74f)* c(sO2) &
             + k(r75f)* c(sO) &
             + k(r76f)* c(sH) &
             + k(r77f)* c(sOH) &
             + k(r78f)* c(sCH3) &
             + k(r79f)* c(sO) &
             + k(r133f)* c(sNO) &
             + k(r143f)* c(sNO2) &
             + k(r34b)* c(sH) &
             + k(r39b)* c(sOH) &
             + k(r44b)* c(sO) &
             + k(r47b)* c(sH) &
             + k(r68b)* c(sHO2) &
             + k(r69b)* c(sOH) &
             + k(r70b)* c(sH2) &
             + k(r71b)* c(sH2O) &
             + k(r72b)* c(sCH4) &
             + k(r93b)* c(sCH3) &
             + k(r95b)* c(sCH2O) &
             + k(r96b)* c(sCH2O) &
             + k(r169b)* c(sN)   )

    HCO_num = ( 0.0_pr &
             + k(r68f)* c(sCH2O) * c(sO2) &
             + k(r69f)* c(sCH2O) * c(sO) &
             + k(r70f)* c(sCH2O) * c(sH) &
             + k(r71f)* c(sCH2O) * c(sOH) &
             + k(r72f)* c(sCH2O) * c(sCH3) &
             + k(r93f)* c(sC2H4) * c(sO) &
             + k(r112f)* c(sC2H4) * c(sO2) &
             + k(r73b)* c(sCO) * c(sH) * m(mM73) &
             + k(r74b)* c(sCO) * c(sHO2) &
             + k(r75b)* c(sCO) * c(sOH) &
             + k(r76b)* c(sCO) * c(sH2) &
             + k(r77b)* c(sCO) * c(sH2O) &
             + k(r78b)* c(sCH4) * c(sCO) &
             + k(r79b)* c(sCO2) * c(sH) &
             + k(r143b)* c(sCO2) * c(sH) * c(sNO)   )

    HCO_ct = HCO_num / HCO_denom

    HCO_CH2 = - ( 0.0_pr &
          + k(r39f) * c(sO2)  ) / HCO_denom

    HCO_CH2GSG = - ( 0.0_pr &
          + k(r34f) * c(sO)  ) / HCO_denom

    HCO_CH = - ( 0.0_pr &
          + k(r44f) * c(sO2) &
          + k(r47f) * c(sOH) &
          + k(r169f) * c(sNO)  ) / HCO_denom

    HCO_C2H3 = - ( 0.0_pr &
          + k(r95f) * c(sO2) &
          + k(r96f) * c(sO2)  ) / HCO_denom

    HCO_HNO = - ( 0.0_pr &
          + k(r133b) * c(sCO)  ) / HCO_denom

    CH3O_denom = tiny(1.0_pr) + ( 0.0_pr &
             + k(r65f)* c(sO2) &
             + k(r66f)* c(sH) &
             + k(r67f)* c(sCH3) &
             + k(r80f)&
             + k(r114f)* c(sOH) &
             + k(r186f)* c(sNO) &
             + k(r52b)* c(sO) &
             + k(r56b)* c(sH) &
             + k(r58b)* c(sOH) &
             + k(r59b)* c(sO2) &
             + k(r60b)* c(sOH) &
             + k(r63b)* c(sH2O) &
             + k(r64b)* c(sHO2) &
             + k(r99b)* c(sCO) &
             + k(r182b)* c(sNO2) &
             + k(r183b)* c(sNO)   )

    CH3O_num = ( 0.0_pr &
             + k(r52f)* c(sCH3) * c(sO2) &
             + k(r56f)* c(sCH3) * c(sOH) &
             + k(r58f)* c(sCH3) * c(sHO2) &
             + k(r63f)* c(sCH3OH) * c(sOH) &
             + k(r64f)* c(sCH3OH) * c(sO2) &
             + k(r112f)* c(sC2H4) * c(sO2) &
             + k(r113f)* c(sCH3) * c(sO) * m(mM113) &
             + k(r183f)* c(sCH3) * c(sNO2) &
             + k(r65b)* c(sCH2O) * c(sHO2) &
             + k(r66b)* c(sCH2O) * c(sH2) &
             + k(r67b)* c(sCH2O) * c(sCH4) &
             + k(r80b)* c(sCH2O) * c(sH)   )

    CH3O_ct = CH3O_num / CH3O_denom

    CH3O_CH3O2 = - ( 0.0_pr &
          + k(r59f) * c(sO) &
          + k(r60f) * c(sH) &
          + k(r103f) * c(sOH) &
          + k(r182f) * c(sNO) &
          + k(r184f) * c(sNO2)  ) / CH3O_denom

    CH3O_C2H3 = - ( 0.0_pr &
          + k(r99f) * c(sO2)  ) / CH3O_denom

    CH3O_HNO = - ( 0.0_pr &
          + k(r186b) * c(sCH2O)  ) / CH3O_denom

    CH3O2_denom = tiny(1.0_pr) + ( 0.0_pr &
             + k(r59f)* c(sO) &
             + k(r60f)* c(sH) &
             + k(r61f)* c(sOH) &
             + k(r102f)&
             + k(r103f)* c(sOH) &
             + k(r104f)* c(sHO2) &
             + k(r182f)* c(sNO) &
             + k(r184f)* c(sNO2) &
             + k(r51b)  )

    CH3O2_num = ( 0.0_pr &
             + k(r51f)* c(sCH3) * c(sO2) &
             + k(r61b)* c(sCH3OH) * c(sO2) &
             + k(r102b)* c(sCH2O) * c(sOH)   )

    CH3O2_ct = CH3O2_num / CH3O2_denom

    CH3O2_CH3O = - ( 0.0_pr &
          + k(r59b) * c(sO2) &
          + k(r60b) * c(sOH) &
          + k(r182b) * c(sNO2)  ) / CH3O2_denom

    CH_denom = tiny(1.0_pr) + ( 0.0_pr &
             + k(r44f)* c(sO2) &
             + k(r45f)* c(sO) &
             + k(r46f)* c(sH) &
             + k(r47f)* c(sOH) &
             + k(r48f)* c(sH2O) &
             + k(r94f)* c(sCH4) &
             + k(r101f)* c(sOH) &
             + k(r167f)* c(sNO) &
             + k(r168f)* c(sNO) &
             + k(r169f)* c(sNO) &
             + k(r170f)* c(sNO) &
             + k(r187f)* c(sN2) &
             + k(r36b)* c(sH2) &
             + k(r42b)* c(sH2) &
             + k(r43b)* c(sH2O)   )

    CH_num = ( 0.0_pr &
             + k(r45b)* c(sCO) * c(sH) &
             + k(r48b)* c(sCH2O) * c(sH) &
             + k(r94b)* c(sC2H4) * c(sH) &
             + k(r167b)* c(sHCN) * c(sO)   )

    CH_ct = CH_num / CH_denom

    CH_CH2 = - ( 0.0_pr &
          + k(r42f) * c(sH) &
          + k(r43f) * c(sOH)  ) / CH_denom

    CH_CH2GSG = - ( 0.0_pr &
          + k(r36f) * c(sH)  ) / CH_denom

    CH_C = - ( 0.0_pr &
          + k(r46b) * c(sH2) &
          + k(r101b) * c(sH2O)  ) / CH_denom

    CH_HCO = - ( 0.0_pr &
          + k(r44b) * c(sO) &
          + k(r47b) * c(sH) &
          + k(r169b) * c(sN)  ) / CH_denom

    CH_NH = - ( 0.0_pr &
          + k(r170b) * c(sCO)  ) / CH_denom

    CH_NCN = - ( 0.0_pr &
          + k(r187b) * c(sH)  ) / CH_denom

    CH_NCO = - ( 0.0_pr &
          + k(r168b) * c(sH)  ) / CH_denom

    C_denom = tiny(1.0_pr) + ( 0.0_pr &
             + k(r49f)* c(sOH) &
             + k(r50f)* c(sO2) &
             + k(r164f)* c(sN2) &
             + k(r165f)* c(sNO) &
             + k(r166f)* c(sNO) &
             + k(r46b)* c(sH2) &
             + k(r101b)* c(sH2O)   )

    C_num = ( 0.0_pr &
             + k(r49b)* c(sCO) * c(sH) &
             + k(r50b)* c(sCO) * c(sO) &
             + k(r166b)* c(sCO) * c(sN)   )

    C_ct = C_num / C_denom

    C_CH = - ( 0.0_pr &
          + k(r46f) * c(sH) &
          + k(r101f) * c(sOH)  ) / C_denom

    C_CN = - ( 0.0_pr &
          + k(r164b) * c(sN) &
          + k(r165b) * c(sO)  ) / C_denom

    CH2GSG_denom = tiny(1.0_pr) + ( 0.0_pr &
             + k(r29f)* c(sN2) &
             + k(r30f)* c(sH2O) &
             + k(r31f)* c(sO2) &
             + k(r32f)* c(sO2) &
             + k(r33f)* c(sO) &
             + k(r34f)* c(sO) &
             + k(r35f)* c(sH2) &
             + k(r36f)* c(sH) &
             + k(r37f)* c(sOH) &
             + k(r38f)* c(sCO2) &
             + k(r107f)* c(sO) &
             + k(r108f)* c(sCH4) &
             + k(r55b)* c(sH2O)   )

    CH2GSG_num = ( 0.0_pr &
             + k(r55f)* c(sCH3) * c(sOH) &
             + k(r32b)* c(sCO) * c(sH2O) &
             + k(r33b)* c(sCO) * c(sH2) &
             + k(r35b)* c(sCH3) * c(sH) &
             + k(r37b)* c(sCH2O) * c(sH) &
             + k(r38b)* c(sCH2O) * c(sCO) &
             + k(r107b)* c(sCO)  *c(sH)** 2.0_pr&
             + k(r108b) *c(sCH3)** 2.0_pr  )

    CH2GSG_ct = CH2GSG_num / CH2GSG_denom

    CH2GSG_CH2 = - ( 0.0_pr &
          + k(r29b) * c(sN2) &
          + k(r30b) * c(sH2O)  ) / CH2GSG_denom

    CH2GSG_CH = - ( 0.0_pr &
          + k(r36b) * c(sH2)  ) / CH2GSG_denom

    CH2GSG_HCO = - ( 0.0_pr &
          + k(r34b) * c(sH)  ) / CH2GSG_denom

    CH2_denom = tiny(1.0_pr) + ( 0.0_pr &
             + k(r39f)* c(sO2) &
             + k(r40f)* c(sO2) &
             + k(r41f)* c(sO) &
             + k(r42f)* c(sH) &
             + k(r43f)* c(sOH) &
             + k(r105f)* c(sO) &
             + k(r106f)* c(sOH) &
             + k(r163f)* c(sN) &
             + k(r171f)* c(sNO) &
             + k(r172f)* c(sNO) &
             + k(r29b)* c(sN2) &
             + k(r30b)* c(sH2O) &
             + k(r57b)* c(sH2O)   )

    CH2_num = ( 0.0_pr &
             + k(r57f)* c(sCH3) * c(sOH) &
             + k(r105b)* c(sCO) * c(sH2) &
             + k(r106b)* c(sCH2O) * c(sH) &
             + k(r163b)* c(sH) * c(sHCN) &
             + k(r171b)* c(sHCN) * c(sOH)   )

    CH2_ct = CH2_num / CH2_denom

    CH2_CH2GSG = - ( 0.0_pr &
          + k(r29f) * c(sN2) &
          + k(r30f) * c(sH2O)  ) / CH2_denom

    CH2_CH = - ( 0.0_pr &
          + k(r42b) * c(sH2) &
          + k(r43b) * c(sH2O)  ) / CH2_denom

    CH2_HCO = - ( 0.0_pr &
          + k(r39b) * c(sOH)  ) / CH2_denom

    CH2_H2CN = - ( 0.0_pr &
          + k(r172b) * c(sO)  ) / CH2_denom

    a_p_a =  (1.0_pr) - (CH2_CH2GSG) * (CH2GSG_CH2)
    a_r_a =  (CH2GSG_CH) - (CH2_CH) * (CH2GSG_CH2)
    a_u_a =  (CH2GSG_HCO) - (CH2_HCO) * (CH2GSG_CH2)
    a_ac_a =  - (CH2_H2CN) * (CH2GSG_CH2)
    a_ag_a = C_CH
    a_at_a =  (CH_CH2GSG) - (CH2_CH2GSG) * (CH_CH2)
    a_av_a =  (1.0_pr) - (CH2_CH) * (CH_CH2)
    a_ay_a =  (CH_HCO) - (CH2_HCO) * (CH_CH2)
    a_bg_a =  - (CH2_H2CN) * (CH_CH2)
    a_cm_a =  (HCO_CH2GSG) - (CH2_CH2GSG) * (HCO_CH2)
    a_co_a =  (HCO_CH) - (CH2_CH) * (HCO_CH2)
    a_cr_a =  (1.0_pr) - (CH2_HCO) * (HCO_CH2)
    a_dz_a =  - (CH2_H2CN) * (HCO_CH2)
    a_dg_a = C2H3_HCO
    a_dv_a = HNO_HCO
    a_eh_a = NH_CH
    a_ga_a = NCN_CH
    a_gp_a = NCO_CH
    a_hc_a =  - (CH2_CH2GSG) * (H2CN_CH2)
    a_he_a =  - (CH2_CH) * (H2CN_CH2)
    a_hh_a =  - (CH2_HCO) * (H2CN_CH2)
    a_hp_a =  (1.0_pr) - (CH2_H2CN) * (H2CN_CH2)
    a_ag_b = a_ag_a
    a_av_b =  (a_av_a) - (a_r_a) * (a_at_a) / (a_p_a)
    a_ay_b =  (a_ay_a) - (a_u_a) * (a_at_a) / (a_p_a)
    a_co_b =  (a_co_a) - (a_r_a) * (a_cm_a) / (a_p_a)
    a_cr_b =  (a_cr_a) - (a_u_a) * (a_cm_a) / (a_p_a)
    a_dg_b = a_dg_a
    a_dv_b = a_dv_a
    a_eh_b = a_eh_a
    a_ga_b = a_ga_a
    a_gp_b = a_gp_a
    a_he_b =  (a_he_a) - (a_r_a) * (a_hc_a) / (a_p_a)
    a_hh_b =  (a_hh_a) - (a_u_a) * (a_hc_a) / (a_p_a)
    a_av_c =  (a_av_b) - (a_ag_b) * (CH_C)
    a_bd_c =  - (C_CN) * (CH_C)
    a_co_c = a_co_b
    a_dl_c = C2H3_CN
    a_eh_c = a_eh_b
    a_fl_c =  - (a_ag_b) * (CN_C)
    a_ft_c =  (1.0_pr) - (C_CN) * (CN_C)
    a_ga_c = a_ga_b
    a_gi_c = NCN_CN
    a_gp_c = a_gp_b
    a_gx_c = NCO_CN
    a_he_c = a_he_b
    a_cr_d =  (a_cr_b) - (a_ay_b) * (a_co_c) / (a_av_c)
    a_cu_d =  - (CH_NH) * (a_co_c) / (a_av_c)
    a_cx_d =  - (CH_NCN) * (a_co_c) / (a_av_c)
    a_cy_d =  - (CH_NCO) * (a_co_c) / (a_av_c)
    a_dg_d = a_dg_b
    a_dv_d = a_dv_b
    a_dy_d = HNO_NH
    a_ek_d =  - (a_ay_b) * (a_eh_c) / (a_av_c)
    a_en_d =  (1.0_pr) - (CH_NH) * (a_eh_c) / (a_av_c)
    a_eq_d =  - (CH_NCN) * (a_eh_c) / (a_av_c)
    a_er_d =  (NH_NCO) - (CH_NCO) * (a_eh_c) / (a_av_c)
    a_fc_d = NNH_NH
    a_fo_d =  - (a_ay_b) * (a_fl_c) / (a_av_c)
    a_fr_d =  - (CH_NH) * (a_fl_c) / (a_av_c)
    a_fu_d =  (CN_NCN) - (CH_NCN) * (a_fl_c) / (a_av_c)
    a_fv_d =  (CN_NCO) - (CH_NCO) * (a_fl_c) / (a_av_c)
    a_gd_d =  - (a_ay_b) * (a_ga_c) / (a_av_c)
    a_gg_d =  - (CH_NH) * (a_ga_c) / (a_av_c)
    a_gj_d =  (1.0_pr) - (CH_NCN) * (a_ga_c) / (a_av_c)
    a_gk_d =  - (CH_NCO) * (a_ga_c) / (a_av_c)
    a_gs_d =  - (a_ay_b) * (a_gp_c) / (a_av_c)
    a_gv_d =  (NCO_NH) - (CH_NH) * (a_gp_c) / (a_av_c)
    a_gy_d =  - (CH_NCN) * (a_gp_c) / (a_av_c)
    a_hz_d =  (1.0_pr) - (CH_NCO) * (a_gp_c) / (a_av_c)
    a_hh_d =  (a_hh_b) - (a_ay_b) * (a_he_c) / (a_av_c)
    a_hk_d =  - (CH_NH) * (a_he_c) / (a_av_c)
    a_hn_d =  - (CH_NCN) * (a_he_c) / (a_av_c)
    a_ho_d =  - (CH_NCO) * (a_he_c) / (a_av_c)
    a_cb_e =  (1.0_pr) - (CH3O2_CH3O) * (CH3O_CH3O2)
    a_df_e = C2H3_CH3O
    a_du_e = HNO_CH3O
    a_cs_f = HCO_C2H3
    a_ct_f = HCO_HNO
    a_dh_f =  (1.0_pr) - (CH3O_C2H3) * (a_df_e) / (a_cb_e)
    a_di_f =  - (CH3O_HNO) * (a_df_e) / (a_cb_e)
    a_dw_f =  - (CH3O_C2H3) * (a_du_e) / (a_cb_e)
    a_dx_f =  (1.0_pr) - (CH3O_HNO) * (a_du_e) / (a_cb_e)
    a_em_f = NH_HNO
    a_fp_f = CN_C2H3
    a_dh_g =  (a_dh_f) - (a_cs_f) * (a_dg_d) / (a_cr_d)
    a_di_g =  (a_di_f) - (a_ct_f) * (a_dg_d) / (a_cr_d)
    a_dw_g =  (a_dw_f) - (a_cs_f) * (a_dv_d) / (a_cr_d)
    a_dx_g =  (a_dx_f) - (a_ct_f) * (a_dv_d) / (a_cr_d)
    a_el_g =  - (a_cs_f) * (a_ek_d) / (a_cr_d)
    a_em_g =  (a_em_f) - (a_ct_f) * (a_ek_d) / (a_cr_d)
    a_fp_g =  (a_fp_f) - (a_cs_f) * (a_fo_d) / (a_cr_d)
    a_fq_g =  - (a_ct_f) * (a_fo_d) / (a_cr_d)
    a_ge_g =  - (a_cs_f) * (a_gd_d) / (a_cr_d)
    a_gf_g =  - (a_ct_f) * (a_gd_d) / (a_cr_d)
    a_gt_g =  - (a_cs_f) * (a_gs_d) / (a_cr_d)
    a_gu_g =  - (a_ct_f) * (a_gs_d) / (a_cr_d)
    a_hi_g =  - (a_cs_f) * (a_hh_d) / (a_cr_d)
    a_hj_g =  - (a_ct_f) * (a_hh_d) / (a_cr_d)
    a_ea_h =  - (a_dl_c) * (a_dw_g) / (a_dh_g)
    a_ep_h =  - (a_dl_c) * (a_el_g) / (a_dh_g)
    a_ft_h =  (a_ft_c) - (a_dl_c) * (a_fp_g) / (a_dh_g)
    a_gi_h =  (a_gi_c) - (a_dl_c) * (a_ge_g) / (a_dh_g)
    a_gx_h =  (a_gx_c) - (a_dl_c) * (a_gt_g) / (a_dh_g)
    a_hm_h =  - (a_dl_c) * (a_hi_g) / (a_dh_g)
    a_en_i =  (a_en_d) - (a_dy_d) * (a_em_g) / (a_dx_g)
    a_fc_i = a_fc_d
    a_fr_i =  (a_fr_d) - (a_dy_d) * (a_fq_g) / (a_dx_g)
    a_gg_i =  (a_gg_d) - (a_dy_d) * (a_gf_g) / (a_dx_g)
    a_gv_i =  (a_gv_d) - (a_dy_d) * (a_gu_g) / (a_dx_g)
    a_hk_i =  (a_hk_d) - (a_dy_d) * (a_hj_g) / (a_dx_g)
    a_fd_j =  (1.0_pr) - (NH_NNH) * (a_fc_i) / (a_en_i)
    a_fg_j =  - (a_er_d) * (a_fc_i) / (a_en_i)
    a_fs_j =  - (NH_NNH) * (a_fr_i) / (a_en_i)
    a_fv_j =  (a_fv_d) - (a_er_d) * (a_fr_i) / (a_en_i)
    a_gh_j =  - (NH_NNH) * (a_gg_i) / (a_en_i)
    a_gk_j =  (a_gk_d) - (a_er_d) * (a_gg_i) / (a_en_i)
    a_gw_j =  - (NH_NNH) * (a_gv_i) / (a_en_i)
    a_hz_j =  (a_hz_d) - (a_er_d) * (a_gv_i) / (a_en_i)
    a_hl_j =  - (NH_NNH) * (a_hk_i) / (a_en_i)
    a_ho_j =  (a_ho_d) - (a_er_d) * (a_hk_i) / (a_en_i)
    a_gj_l =  (a_gj_d) - (a_fu_d) * (a_gi_h) / (a_ft_h)
    a_gk_l =  (a_gk_j) - (a_fv_j) * (a_gi_h) / (a_ft_h)
    a_gy_l =  (a_gy_d) - (a_fu_d) * (a_gx_h) / (a_ft_h)
    a_hz_l =  (a_hz_j) - (a_fv_j) * (a_gx_h) / (a_ft_h)
    a_hn_l =  (a_hn_d) - (a_fu_d) * (a_hm_h) / (a_ft_h)
    a_ho_l =  (a_ho_j) - (a_fv_j) * (a_hm_h) / (a_ft_h)
    A_A_A =  (CH2GSG_ct) - (CH2_ct) * (CH2GSG_CH2)
    A_B_A = C_ct
    A_C_A =  (CH_ct) - (CH2_ct) * (CH_CH2)
    A_D_A = CH3O2_ct
    A_E_A = CH3O_ct
    A_F_A =  (HCO_ct) - (CH2_ct) * (HCO_CH2)
    A_G_A = C2H3_ct
    A_H_A = HNO_ct
    A_I_A = NH_ct
    A_J_A = NNH_ct
    A_K_A = CN_ct
    A_L_A = NCN_ct
    A_M_A = NCO_ct
    A_N_A =  (H2CN_ct) - (CH2_ct) * (H2CN_CH2)
    A_B_B = A_B_A
    A_C_B =  (A_C_A) - (A_A_A) * (a_at_a) / (a_p_a)
    A_D_B = A_D_A
    A_E_B = A_E_A
    A_F_B =  (A_F_A) - (A_A_A) * (a_cm_a) / (a_p_a)
    A_G_B = A_G_A
    A_H_B = A_H_A
    A_I_B = A_I_A
    A_J_B = A_J_A
    A_K_B = A_K_A
    A_L_B = A_L_A
    A_M_B = A_M_A
    A_N_B =  (A_N_A) - (A_A_A) * (a_hc_a) / (a_p_a)
    A_C_C =  (A_C_B) - (A_B_B) * (CH_C)
    A_D_C = A_D_B
    A_E_C = A_E_B
    A_F_C = A_F_B
    A_G_C = A_G_B
    A_H_C = A_H_B
    A_I_C = A_I_B
    A_J_C = A_J_B
    A_K_C =  (A_K_B) - (A_B_B) * (CN_C)
    A_L_C = A_L_B
    A_M_C = A_M_B
    A_N_C = A_N_B
    A_D_D = A_D_C
    A_E_D = A_E_C
    A_F_D =  (A_F_C) - (A_C_C) * (a_co_c) / (a_av_c)
    A_G_D = A_G_C
    A_H_D = A_H_C
    A_I_D =  (A_I_C) - (A_C_C) * (a_eh_c) / (a_av_c)
    A_J_D = A_J_C
    A_K_D =  (A_K_C) - (A_C_C) * (a_fl_c) / (a_av_c)
    A_L_D =  (A_L_C) - (A_C_C) * (a_ga_c) / (a_av_c)
    A_M_D =  (A_M_C) - (A_C_C) * (a_gp_c) / (a_av_c)
    A_N_D =  (A_N_C) - (A_C_C) * (a_he_c) / (a_av_c)
    A_E_E =  (A_E_D) - (A_D_D) * (CH3O_CH3O2)
    A_F_E = A_F_D
    A_G_E = A_G_D
    A_H_E = A_H_D
    A_I_E = A_I_D
    A_J_E = A_J_D
    A_K_E = A_K_D
    A_L_E = A_L_D
    A_M_E = A_M_D
    A_N_E = A_N_D
    A_F_F = A_F_E
    A_G_F =  (A_G_E) - (A_E_E) * (a_df_e) / (a_cb_e)
    A_H_F =  (A_H_E) - (A_E_E) * (a_du_e) / (a_cb_e)
    A_I_F = A_I_E
    A_J_F = A_J_E
    A_K_F = A_K_E
    A_L_F = A_L_E
    A_M_F = A_M_E
    A_N_F = A_N_E
    A_G_G =  (A_G_F) - (A_F_F) * (a_dg_d) / (a_cr_d)
    A_H_G =  (A_H_F) - (A_F_F) * (a_dv_d) / (a_cr_d)
    A_I_G =  (A_I_F) - (A_F_F) * (a_ek_d) / (a_cr_d)
    A_J_G = A_J_F
    A_K_G =  (A_K_F) - (A_F_F) * (a_fo_d) / (a_cr_d)
    A_L_G =  (A_L_F) - (A_F_F) * (a_gd_d) / (a_cr_d)
    A_M_G =  (A_M_F) - (A_F_F) * (a_gs_d) / (a_cr_d)
    A_N_G =  (A_N_F) - (A_F_F) * (a_hh_d) / (a_cr_d)
    A_H_H =  (A_H_G) - (A_G_G) * (a_dw_g) / (a_dh_g)
    A_I_H =  (A_I_G) - (A_G_G) * (a_el_g) / (a_dh_g)
    A_J_H = A_J_G
    A_K_H =  (A_K_G) - (A_G_G) * (a_fp_g) / (a_dh_g)
    A_L_H =  (A_L_G) - (A_G_G) * (a_ge_g) / (a_dh_g)
    A_M_H =  (A_M_G) - (A_G_G) * (a_gt_g) / (a_dh_g)
    A_N_H =  (A_N_G) - (A_G_G) * (a_hi_g) / (a_dh_g)
    A_I_I =  (A_I_H) - (A_H_H) * (a_em_g) / (a_dx_g)
    A_J_I = A_J_H
    A_K_I =  (A_K_H) - (A_H_H) * (a_fq_g) / (a_dx_g)
    A_L_I =  (A_L_H) - (A_H_H) * (a_gf_g) / (a_dx_g)
    A_M_I =  (A_M_H) - (A_H_H) * (a_gu_g) / (a_dx_g)
    A_N_I =  (A_N_H) - (A_H_H) * (a_hj_g) / (a_dx_g)
    A_J_J =  (A_J_I) - (A_I_I) * (a_fc_i) / (a_en_i)
    A_K_J =  (A_K_I) - (A_I_I) * (a_fr_i) / (a_en_i)
    A_L_J =  (A_L_I) - (A_I_I) * (a_gg_i) / (a_en_i)
    A_M_J =  (A_M_I) - (A_I_I) * (a_gv_i) / (a_en_i)
    A_N_J =  (A_N_I) - (A_I_I) * (a_hk_i) / (a_en_i)
    A_K_K =  (A_K_J) - (A_J_J) * (a_fs_j) / (a_fd_j)
    A_L_K =  (A_L_J) - (A_J_J) * (a_gh_j) / (a_fd_j)
    A_M_K =  (A_M_J) - (A_J_J) * (a_gw_j) / (a_fd_j)
    A_N_K =  (A_N_J) - (A_J_J) * (a_hl_j) / (a_fd_j)
    A_L_L =  (A_L_K) - (A_K_K) * (a_gi_h) / (a_ft_h)
    A_M_L =  (A_M_K) - (A_K_K) * (a_gx_h) / (a_ft_h)
    A_N_L =  (A_N_K) - (A_K_K) * (a_hm_h) / (a_ft_h)
    A_M_M =  (A_M_L) - (A_L_L) * (a_gy_l) / (a_gj_l)
    A_N_M =  (A_N_L) - (A_L_L) * (a_hn_l) / (a_gj_l)
    A_N_N =  (A_N_M) - (A_M_M) * (a_ho_l) / (a_hz_l)

    cqss(sqssH2CN) = ( A_N_N ) / ( a_hp_a )  

    cqss(sqssNCO) = A_M_M / a_hz_l  

    cqss(sqssNCN) = (A_L_L - (a_gk_l) * cqss(sqssNCO)) / (a_gj_l)  

    cqss(sqssCN) = (A_K_K - (a_fv_j) * cqss(sqssNCO) - (a_fu_d) &
                 * cqss(sqssNCN)) / (a_ft_h)  

    cqss(sqssNNH) = (A_J_J - (a_fg_j) * cqss(sqssNCO)) / (a_fd_j)  

    cqss(sqssNH) = (A_I_I - (a_er_d) * cqss(sqssNCO) - (a_eq_d) &
                 * cqss(sqssNCN) - (a_ep_h) * cqss(sqssCN) - (NH_NNH) &
                 * cqss(sqssNNH)) / (a_en_i)  

    cqss(sqssHNO) = (A_H_H - (a_ea_h) * cqss(sqssCN) - (a_dy_d) &
                 * cqss(sqssNH)) / (a_dx_g)  

    cqss(sqssC2H3) = (A_G_G - (a_dl_c) * cqss(sqssCN) - (a_di_g) &
                 * cqss(sqssHNO)) / (a_dh_g)  

    cqss(sqssHCO) = (A_F_F - (a_dz_a) * cqss(sqssH2CN) - (a_cy_d) &
                 * cqss(sqssNCO) - (a_cx_d) * cqss(sqssNCN) &
                 - (a_cu_d) * cqss(sqssNH) - (a_ct_f) * cqss(sqssHNO) &
                 - (a_cs_f) * cqss(sqssC2H3)) / (a_cr_d)  

    cqss(sqssCH3O) = (A_E_E - (CH3O_HNO) * cqss(sqssHNO) - (CH3O_C2H3) &
                 * cqss(sqssC2H3)) / (a_cb_e)  

    cqss(sqssCH3O2) = A_D_D - (CH3O2_CH3O) * cqss(sqssCH3O)  

    cqss(sqssCH) = (A_C_C - (a_bg_a) * cqss(sqssH2CN) - (CH_NCO) &
                 * cqss(sqssNCO) - (CH_NCN) * cqss(sqssNCN) &
                 - (a_bd_c) * cqss(sqssCN) - (CH_NH) * cqss(sqssNH) &
                 - (a_ay_b) * cqss(sqssHCO)) / (a_av_c)  

    cqss(sqssC) = A_B_B - (C_CN) * cqss(sqssCN) - (a_ag_b) * cqss(sqssCH)  

    cqss(sqssCH2GSG) = (A_A_A - (a_ac_a) * cqss(sqssH2CN) - (a_u_a) &
                 * cqss(sqssHCO) - (a_r_a) * cqss(sqssCH)) / (a_p_a)  

    cqss(sqssCH2) = CH2_ct - (CH2_H2CN) * cqss(sqssH2CN) - (CH2_HCO) &
                 * cqss(sqssHCO) - (CH2_CH) * cqss(sqssCH) - (CH2_CH2GSG) &
                 * cqss(sqssCH2GSG)  

    C2H5_denom = tiny(1.0_pr) + ( 0.0_pr &
             + k(r82f)* c(sH) &
             + k(r89f)* c(sO2) &
             + k(r83b)* c(sOH) &
             + k(r84b)* c(sH2) &
             + k(r85b)* c(sH2O) &
             + k(r86b)* c(sCH4) &
             + k(r87b)&
             + k(r88b)* c(sH)   )

    C2H5_num = ( 0.0_pr &
             + k(r87f)* c(sC2H4) * c(sH) &
             + k(r88f) *c(sCH3)** 2.0_pr&
             + k(r89b)* c(sC2H4) * c(sHO2)   )

    C2H5_ct = C2H5_num / C2H5_denom

    C2H5_C2H6 = - ( 0.0_pr &
          + k(r83f) * c(sO) &
          + k(r84f) * c(sH) &
          + k(r85f) * c(sOH) &
          + k(r86f) * c(sCH3) &
          + k(r82b)  ) / C2H5_denom

    C2H6_denom = tiny(1.0_pr) + ( 0.0_pr &
             + k(r83f)* c(sO) &
             + k(r84f)* c(sH) &
             + k(r85f)* c(sOH) &
             + k(r86f)* c(sCH3) &
             + k(r109f)&
             + k(r81b)&
             + k(r82b)  )

    C2H6_num = ( 0.0_pr &
             + k(r81f) *c(sCH3)** 2.0_pr&
             + k(r109b)* c(sC2H4) * c(sH2)   )

    C2H6_ct = C2H6_num / C2H6_denom

    C2H6_C2H5 = - ( 0.0_pr &
          + k(r82f) * c(sH) &
          + k(r83b) * c(sOH) &
          + k(r84b) * c(sH2) &
          + k(r85b) * c(sH2O) &
          + k(r86b) * c(sCH4)  ) / C2H6_denom

    b_c_a =  (1.0_pr) - (C2H6_C2H5) * (C2H5_C2H6)
    B_A_A =  (C2H5_ct) - (C2H6_ct) * (C2H5_C2H6)

    cqss(sqssC2H5) = ( B_A_A ) / ( b_c_a )  

    cqss(sqssC2H6) = C2H6_ct - (C2H6_C2H5) * cqss(sqssC2H5)  

    cqss = max(cqss, tiny(1.0_pr))
    cqss = min(cqss, 1e03_pr)

    ! Necessary for very low concentration variations
    ! Needs to be integrated only for Cantera
    do index=1,nqss
      if (cqss(index) /= cqss(index)) then
        cqss(index) = tiny(1.0_pr)
      end if
    end do

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
    !do  k = 1, nspec
    !   if (c(k)<1.0e-20_pr) c(k) = 0.0_pr
    !end do

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

