Device MOS {
  Electrode {
    { Name="PW_Contact" Voltage= 0.0 }
    { Name="Source" Voltage= 0.0 }
    { Name="Drain" Voltage= 0.0 }
    { Name="Gate" Voltage= 0.0 workfunction=@wf@ }
  }
  File {
    Grid= "@tdr@"
    Parameter= "@parameter@"
    Current= "@plot@"
    Plot= "@tdrdat@"
  }
  Physics {
    EffectiveIntrinsicDensity(OldSlotboom)
    eQuantumPotential(density)
    Mobility(
      DopingDependence
      HighFieldsaturation(GradQuasiFermi)
      Enormal(IALMob)
    )
  }
}
File {
  Output= "@log@"
  ACExtract= "@acplot@"
}
Plot {
  eDensity hDensity
  TotalCurrent/Vector eCurrent/Vector hCurrent/Vector
  eMobility hMobility
  ElectricField/Vector Potential SpaceCharge
  Doping DonorConcentration AcceptorConcentration
  BandGap ConductionBand ValenceBand
}
Math {
  Extrapolate
  Derivatives
  RelErrControl
  Digits= 5 
  Notdamped= 100
  Iterations= 25
  ExitOnFailure
  TensorGridAniso
  StressMobilityDependence = TensorFactor
  Number_of_Threads= 4
}
System {
  MOS mos ("Gate"=g "Source"=s "Drain"=d "PW_Contact"=b)
  Vsource_pset vg ( g 0 ){ dc = 0 }
  Vsource_pset vs ( s 0 ){ dc = 0 }
  Vsource_pset vd ( d 0 ){ dc = 0 }
  Vsource_pset vb ( b 0 ){ dc = 0 }
}
Solve {
  Coupled(Iterations= 1000 LineSearchDamping= 1e-8){ Poisson }
  Coupled{ Poisson Electron Hole }
  
  Quasistationary(
    InitialStep=1e-7 Minstep=1e-12 MaxStep=0.1 Increment=2
    Goal{ Parameter= vg.dc Voltage= @Vmin@ }
  ){ Coupled { Poisson Electron Hole } }

  NewCurrentFile=""
  Quasistationary(
    InitialStep=1e-7 Minstep=1e-12 MaxStep=0.1 Increment=2
    Goal { Parameter= vg.dc Voltage=@Vmax@ }
  ){ ACCoupled (
       StartFrequency= 1e6 EndFrequency= 1e6 NumberOfPoints= 1 Decade
       Node(s d g b) Exclude(vs vd vg vb)
       ACCompute (Time= (Range = (0 1) Intervals= 50))
     ){ Poisson Electron Hole }
  }
}
