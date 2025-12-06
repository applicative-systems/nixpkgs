{
  buildPythonPackage,
  iproute2,
  mypy,
  ruff,
  setuptools,
  systemd,
}:

buildPythonPackage {
  pname = "run-nspawn";
  version = "1.0";
  pyproject = true;

  src = ./src;

  build-system = [
    setuptools
  ];

  propagatedBuildInputs = [
    systemd
    iproute2
  ];

  doCheck = true;

  nativeCheckInputs = [
    mypy
    ruff
  ];

  checkPhase = ''
    echo -e "\x1b[32m## run mypy\x1b[0m"
    mypy run_nspawn
    echo -e "\x1b[32m## run ruff check\x1b[0m"
    ruff check .
    echo -e "\x1b[32m## run ruff format\x1b[0m"
    ruff format --check --diff .
  '';
}
