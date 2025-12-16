(sde:clear)
(define Lgate 0.028)
(define Tox_IL 0.0007)
(define Tox_HK 0.002)
(define Tpoly 0.050)
(define Lspacer 0.015)
(define Lsd 0.080)
(define N_Well 1e17)
(define N_Chan 2e18)
(define N_SD 1e20)
(define N_Ext 2e19)

; Substrate & Gate Stack
(sdegeo:create-rectangle (position -0.123 1.0 0) (position 0.123 0.0 0) "Silicon" "Substrate")
(sdegeo:create-rectangle (position -0.014 0.0 0) (position 0.014 -0.0007 0) "SiO2" "Gate_Oxide_IL")
(sdegeo:create-rectangle (position -0.014 -0.0007 0) (position 0.014 -0.0027 0) "HfO2" "Gate_Oxide_HK")
(sdegeo:create-rectangle (position -0.014 -0.0027 0) (position 0.014 -0.0527 0) "TiN" "Gate_Metal")

; Spacers & Contacts
(sdegeo:create-rectangle (position -0.029 0.0 0) (position -0.014 -0.0527 0) "Si3N4" "Spacer_Left")
(sdegeo:create-rectangle (position 0.014 0.0 0) (position 0.029 -0.0527 0) "Si3N4" "Spacer_Right")

(sdegeo:define-contact-set "Gate" 4 (color:rgb 1 0 0) "##")
(sdegeo:set-current-contact-set "Gate")
(sdegeo:set-contact-edges (find-edge-id (position 0.0 -0.0527 0)))

(sdegeo:define-contact-set "Source" 4 (color:rgb 0 0 1) "||")
(sdegeo:set-current-contact-set "Source")
(sdegeo:set-contact-edges (find-edge-id (position -0.069 0.0 0)))

(sdegeo:define-contact-set "Drain" 4 (color:rgb 0 0 1) "||")
(sdegeo:set-current-contact-set "Drain")
(sdegeo:set-contact-edges (find-edge-id (position 0.069 0.0 0)))

(sdegeo:define-contact-set "PW_Contact" 4 (color:rgb 0 1 0) "//")
(sdegeo:set-current-contact-set "PW_Contact")
(sdegeo:set-contact-edges (find-edge-id (position 0.0 1.0 0)))

; Doping Profiles
(sdedr:define-constant-profile "Const.PWell" "BoronActiveConcentration" N_Well)
(sdedr:define-constant-profile-region "Place.PWell" "Const.PWell" "Substrate")

(sdedr:define-gaussian-profile "Gauss.Channel" "BoronActiveConcentration" "PeakPos" 0.0 "PeakVal" N_Chan "ValueAtDepth" N_Well "Depth" 0.05 "Gauss" "Factor" 0.8)
(sdedr:define-analytical-profile-placement "Place.Channel" "Gauss.Channel" "Substrate")

(sdedr:define-gaussian-profile "Gauss.SD" "ArsenicActiveConcentration" "PeakPos" 0.0 "PeakVal" N_SD "ValueAtDepth" N_Well "Depth" 0.1 "Gauss" "Factor" 0.8)
(sdedr:define-analytical-profile-placement "Place.Source" "Gauss.SD" "RefWin.Source" "NoReplace" "EvalWin.Source")
(sdedr:define-refinement-window "RefWin.Source" "Line" (position -0.123 0.0 0) (position -0.029 0.0 0))
(sdedr:define-analytical-profile-placement "Place.Drain" "Gauss.SD" "RefWin.Drain" "NoReplace" "EvalWin.Drain")
(sdedr:define-refinement-window "RefWin.Drain" "Line" (position 0.029 0.0 0) (position 0.123 0.0 0))

; Meshing
(sdedr:define-refinement-size "Ref.Channel" 0.002 0.002 0.0 0.001 0.001 0.0)
(sdedr:define-refinement-window "Win.Channel" "Rectangle" (position -0.02 0.05 0) (position 0.02 -0.05 0))
(sdedr:define-refinement-placement "Place.Channel" "Ref.Channel" "Win.Channel")

(sde:build-mesh "snmesh" "-a -c conforming" "n@node@_msh")
