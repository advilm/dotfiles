{moduleSettings, ...}: let
  governor_on_ac = moduleSettings.tlp.governor_on_ac or "performance";
  energy_performance_on_ac = moduleSettings.tlp.energy_performance_on_ac or "performance";
in {
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = governor_on_ac;
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_AC = energy_performance_on_ac;
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 50;

      STOP_CHARGE_THRESH_BAT1 = 80;
    };
  };
}
