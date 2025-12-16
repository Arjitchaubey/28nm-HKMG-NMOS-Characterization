#setdep @node|sdevice@
load_library extract
lib::SetInfoDef 1
set N @node@

if {[lsearch [list_plots] Plot_CV] == -1} {
    create_plot -1d -name Plot_CV
}
select_plots Plot_CV
load_file @Vd@_n@node@_ac_des.plt -name PLT_CV($N)
set Vgs [get_variable_data "Gate OuterVoltage" -dataset PLT_CV($N)]
set Cap [get_variable_data "Gate TotalCapacitance" -dataset PLT_CV($N)]
create_curve -name CV_Curve($N) -dataset PLT_CV($N) -axisX "Gate OuterVoltage" -axisY "Gate TotalCapacitance"
set_curve_prop CV_Curve($N) -label "C(g,g) Node $N" -color red -line_style solid -line_width 3
set_axis_prop -plot Plot_CV -axis x -title "Gate Voltage (V)"
set_axis_prop -plot Plot_CV -axis y -title "Capacitance (F)"
export_view NMOS_Cap_Comp.png -plots Plot_CV -format png -overwrite
