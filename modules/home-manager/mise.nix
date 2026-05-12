_: {
  programs.mise = {
    enable = true;
    enableZshIntegration = true;
    globalConfig = {
      tools = {
        node = "latest";
        uv = "latest";
        bun = "latest";
        aws-cli = "latest";
        terraform = "latest";
        claude = "latest";
        codex = "latest";
				opencode = "latest";
        gemini-cli = "latest";
        "npm:@playwright/cli" = "latest";
        "npm:ctx7" = "latest";
        "github:rtk-ai/rtk" = "latest";
        "github:trkbt10/indexion" = "latest";
				"github:k1LoW/mo" = "latest";
      };
      settings = {
        all_compile = false; # Disable forced compilation
        experimental = true; # もし新しい機能を使うなら
				npm.package_manager = "bun";
      };
    };
  };
}
