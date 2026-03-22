_: {
  programs.mise = {
    enable = true;
    enableZshIntegration = true;
    globalConfig = {
      tools = {
				node = "latest";
				uv = "latest";
				aws-cli = "latest";
				terraform = "latest";
				claude = "latest";
        gemini-cli = "latest";
      };
      settings = {
        all_compile = false; # 強制コンパイルをオフ
        experimental = true; # もし新しい機能を使うなら
      };
    };
  };
}
