package Solarkollektor
  partial class ICON_Kollektor
    annotation(
      Icon(graphics = {Rectangle(extent = {{-98, 98}, {98, -98}}), Text(origin = {-22, -4}, extent = {{-48, -16}, {106, 30}}, textString = "solarkollektormodell")}, coordinateSystem(initialScale = 0.1)));
  end ICON_Kollektor;

  model Hauptprogramm
    parameter String file_weather = Modelica.Utilities.Files.loadResource("modelica://Solarkollektor/Potsdam2019_mat.mat");
    Solarkollektor.Kollektormodell kollektormodell annotation(
      Placement(visible = true, transformation(origin = {51, -53}, extent = {{-29, -29}, {29, 29}}, rotation = 0)));
    Solarkollektor.DataSource data(file = file_weather) annotation(
      Placement(visible = true, transformation(origin = {-74, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.RealExpression Ta_INPUT(y = data.Ta) annotation(
      Placement(visible = true, transformation(origin = {-46, -74}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Sources.RealExpression G_INPUT(y = data.G) annotation(
      Placement(visible = true, transformation(origin = {-48, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(Ta_INPUT.y, kollektormodell.ta) annotation(
      Line(points = {{-34, -74}, {20, -74}, {20, -70}, {24, -70}}, color = {0, 0, 127}));
  connect(G_INPUT.y, kollektormodell.Gt) annotation(
      Line(points = {{-36, -32}, {22, -32}, {22, -36}}, color = {0, 0, 127}));
  protected
    annotation(
      experiment(StartTime = 0, StopTime = 3.1536e+07, Tolerance = 1e-06, Interval = 3600));
  end Hauptprogramm;

  model Kollektormodell
    extends ICON_Kollektor;
    //Types
    type HeatLossCoeficient = Real(unit = "w/(m2*K)");
    type Temperature = Real(unit = "deg");
    type HeatCapacity = Real(unit = "J/(m2*K)");
    type area = Real(unit = "m2");
    type MassFlow = Real(unit = "kg/h");
    //parameters
    parameter area A_g = 2.0 "gross area";
    parameter Real eta = 0.8 "top efficiency";
    parameter MassFlow m_dot = 75.0 "mass flow";
    parameter HeatLossCoeficient a_1 = 3.5;
    parameter HeatLossCoeficient a_2 = 0.01;
    parameter HeatCapacity a_5 = 5000;
    parameter Temperature Tci = 75 "collector entry temperatur";
    //Varialbes
    Real Tco "collector outlet temperature";
    Real Tm "middle temperature";
    Real cp "specificheat";
    Real Qabs "absorbs amout of heat";
    Real Quse "using energy";
    Real Qvp "Lost Energy";
    Real Qv "lost energy";
    Modelica.Blocks.Interfaces.RealInput Gt annotation(
      Placement(visible = true, transformation(origin = {-98, 56}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-98, 56}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput ta annotation(
      Placement(visible = true, transformation(origin = {-94, -56}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-94, -56}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  equation
    Qabs = eta * Gt * A_g;
    Qvp = (a_1 * (Tm - ta) + a_2 * (Tm - ta) * (Tm - ta)) * A_g;
    Quse = m_dot * cp * (Tco - Tci) / 3.6;
    der(Tm) = (Qabs - Qvp - Quse) / (A_g * a_5);
    Tm = (Tci + Tco) / 2;
    cp = 4.21091532 - 1.85646462e-3 * Tm + 3.09300765e-5 * Tm * Tm - 1.22631409e-7 * Tm * Tm * Tm;
    Qv = -Qvp;
  end Kollektormodell;

  model DataSource
    extends ICON_Table;
    import SI = Modelica.SIunits;
    parameter String file = "modelica://Solarkollektor/Potsdam2019_mat.mat";
    output SI.Irradiance G;
    output Real Ta;
  protected
    Modelica.Blocks.Sources.CombiTimeTable DataTable(columns = 1:8, fileName = file, smoothness = Modelica.Blocks.Types.Smoothness.ContinuousDerivative, tableName = "num", tableOnFile = true, timeScale = 3600) annotation(
      Placement(visible = true, transformation(origin = {-62, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    Ta = DataTable.y[3];
    G = DataTable.y[8];
  end DataSource;

  partial class ICON_Table
    annotation(
      Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Ellipse(extent = {{-92, 94}, {-92, 94}}, endAngle = 360), Line(origin = {-2, 68}, points = {{-82, 0}, {82, 0}}), Line(origin = {-1, 28}, points = {{-81, 0}, {81, 0}, {81, 0}}), Line(origin = {-2, -24}, points = {{-82, 0}, {82, 0}, {82, 0}}), Line(origin = {-3, -67}, points = {{-83, -1}, {83, 1}, {83, 1}})}, coordinateSystem(initialScale = 0.1)));
  end ICON_Table;
  annotation(
    uses(Modelica(version = "3.2.3")));
end Solarkollektor;
