package Modell02
  model hauptprogramme
    package Medium = BuildingSystems.Media.Antifreeze.PropyleneGlycolWater(X_a = 0.40, property_T = 293.15);
    Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature prescribedTemperature annotation(
      Placement(visible = true, transformation(origin = {-2, 16}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    BuildingSystems.Fluid.Sources.MassFlowSource_T bou1( redeclare package Medium = Medium, T = 348.15, m_flow = 0.02083,nPorts = 1) annotation(
      Placement(visible = true, transformation(origin = {-93, -9}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
    BuildingSystems.Fluid.Sources.Boundary_pT bou2(redeclare package Medium = Medium, nPorts = 1) annotation(
      Placement(visible = true, transformation(origin = {-5, -9}, extent = {{11, -11}, {-11, 11}}, rotation = 0)));
    BuildingSystems.Climate.SolarRadiationTransformers.SolarRadiationTransformerIsotropicSky radiation(rhoAmb = 0.2) annotation(
      Placement(visible = true, transformation(origin = {-58, 38}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
    BuildingSystems.Climate.WeatherData.WeatherDataReader weatherData(redeclare block WeatherData = Modell02.Potsdam2019_Meteonorm_ASCII) "time Gdot_beam Gdot_diffuse T_air_env" annotation(
      Placement(visible = true, transformation(origin = {-83, 68}, extent = {{-13, -12}, {13, 12}}, rotation = 0)));
    BuildingSystems.Technologies.SolarThermal.ThermalCollector collector(redeclare package Medium = Medium, redeclare Kollektordata.Modell2SolarCollector collectorData, angleDegAzi = 0.0, angleDegTil = 45.0, dp_nominal = 2.0, m_flow_nominal = 0.02083, nEle = 1) annotation(
      Placement(visible = true, transformation(origin = {-43, -8}, extent = {{-11, -10}, {11, 10}}, rotation = 0)));
  equation
  connect(collector.heatPortCon, prescribedTemperature.port) annotation(
      Line(points = {{-37.5, 1}, {-37.5, 16}, {-12, 16}}, color = {191, 0, 0}));
  connect(collector.angleDegAzi, radiation.angleDegAzi) annotation(
      Line(points = {{-51, -17}, {-51, -20}, {-74, -20}, {-74, 30}, {-69, 30}}, color = {0, 0, 127}));
  connect(weatherData.IrrDifHor, radiation.IrrDifHor) annotation(
      Line(points = {{-84, 55}, {-84, 41}, {-69, 41}}, color = {0, 0, 127}));
  connect(weatherData.longitudeDeg, radiation.longitudeDeg) annotation(
      Line(points = {{-69, 76}, {-58, 76}, {-58, 49}}, color = {0, 0, 127}));
  connect(radiation.radiationPort, collector.radiationPort) annotation(
      Line(points = {{-47, 38}, {-44, 38}, {-44, 1}}));
  connect(weatherData.TAirRef, prescribedTemperature.T) annotation(
      Line(points = {{-92, 55}, {-92, 52}, {-22, 52}, {-22, 16}, {10, 16}}, color = {0, 0, 127}));
  connect(collector.angleDegTil, radiation.angleDegTil) annotation(
      Line(points = {{-48.5, -17}, {-48.5, -20}, {-74, -20}, {-74, 35}, {-69, 35}}, color = {0, 0, 127}));
  connect(bou1.ports[1], collector.port_a) annotation(
      Line(points = {{-80, -9}, {-66, -9}, {-66, -8}, {-54, -8}}, color = {0, 127, 255}));
  connect(weatherData.longitudeDeg0, radiation.longitudeDeg0) annotation(
      Line(points = {{-69, 74}, {-52, 74}, {-52, 49}}, color = {0, 0, 127}));
  connect(radiation.latitudeDeg, weatherData.latitudeDeg) annotation(
      Line(points = {{-63, 49}, {-63, 79}, {-69, 79}}, color = {0, 0, 127}));
  connect(collector.port_b, bou2.ports[1]) annotation(
      Line(points = {{-32, -8}, {-27, -8}, {-27, -9}, {-16, -9}}, color = {0, 127, 255}));
  connect(weatherData.IrrDirHor, radiation.IrrDirHor) annotation(
      Line(points = {{-87, 55}, {-87, 46}, {-69, 46}}, color = {0, 0, 127}));
  annotation(
      uses(Modelica(version = "3.2.3"), BuildingSystems(version = "2.0.0-beta")),
      Diagram(graphics = {Text(lineColor = {0, 0, 255}, extent = {{-94, -26}, {-4, -46}}, textString = "Solar thermal collector under real weather data")}),
      experiment(StartTime = 0, StopTime = 3.1536e+07, Tolerance = 1e-06, Interval = 3600));
  end hauptprogramme;

  model Kollektordata
    record Modell2SolarCollector = BuildingSystems.Technologies.SolarThermal.Data.Collectors.CollectorPartial(final IAMC = 0.92, final V_A = 1 / 0.1 / 980, final C_0 = 0.80, final C_1 = 3.5, final C_2 = 0.01, A = 2.0) annotation(
      uses(BuildingSystems(version = "2.0.0-beta")));
  end Kollektordata;

  block Potsdam2019_Meteonorm_ASCII
    extends BuildingSystems.Climate.WeatherData.BaseClasses.WeatherDataFileASCII(info = "Source: Meteonorm 7.0", filNam = Modelica.Utilities.Files.loadResource("modelica://Modell02/Potsdam2019.txt"), final tabNam = "tab1", final timeFac = 1.0 / 3600.0, final deltaTime = 1800.0, final columns = {5, 6, 3, 8, 9, 4, 7}, final scaleFac = {1.0, 1.0, 1.0, 1.0, 1.0, 0.01, 1.0}, final latitudeDeg = 49.47, final longitudeDeg = 9.57, final longitudeDeg_0 = 1.0);
    // beam horizontal radiation
    // diffuse horizontal radiation
    // air temperature
    // wind speed
    // wind direction
    // relative humidity
    // cloud cover
    annotation(
      Documentation(info = "<html>source: Meteonorm 7.0</html>"));
  end Potsdam2019_Meteonorm_ASCII;
end Modell02;
