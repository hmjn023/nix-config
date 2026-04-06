_: {
  programs.mise = {
    enable = true;
    enableZshIntegration = true;
    globalConfig = {
      tools = {
        node = "latest";
        uv = "latest";
        bun = "latest";
        pnpm = "latest";
        aws-cli = "latest";
        terraform = "latest";
        claude = "latest";
        codex = "latest";
        gemini-cli = "latest";
        "npm:ctx7" = "latest";
        "npm:@playwright/cli" = "latest";
				"cargo:rtk-ai/rtk" = "latest";
				"github:trkbt10/indexion" = "latest";
      };
      settings = {
        all_compile = false; # Disable forced compilation
        experimental = true; # もし新しい機能を使うなら
      };
    };
  };
}
