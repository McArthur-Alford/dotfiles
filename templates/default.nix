_:
{
  default = {
    path = ./default;
    description = "Default";
    welcomeText = ''
      # A empty, default template
      ...to modify to your hearts content
    '';
  };
  rust = {
    path = ./rust;
    description = "Rust";
    welcomeText = ''
      # A simple Rust/Cargo template
      Provides access to rust and cargo. Obviously.
    '';
  };
  c = {
    path = ./c;
    description = "C";
    welcomeText = ''
      # A simple C template
      Provides GCC and clang
    '';
  };
  # haskell = {};
  # java = {};
  python311 = {
    path = ./python311;
    description = "Python311";
    welcomeText = ''
      # A simple python 3.11 template
    '';
  };
  torchrocm = {
    path = ./torchrocm;
    description = "Python311 With Pytorch/ROCM";
    welcomeText = ''
      # A convoluted python 3.11 template with torch/ROCM support
    '';
  };
  latex = {
    path = ./latex;
    description = "LaTeX Devshell";
    welcomeText = ''
      # Welcome to the magical world of LaTeX!
    '';
  };
  elixir = {
    path = ./elixir;
    description = "Elixir Devshell";
    welcomeText = ''
      # Welcome to the alchemy laboratory
    '';
  };
}
