{ lib
, buildPythonPackage
, pythonOlder
, fetchFromGitHub
, hatchling
, aiosqlite
, anyio
, y-py
, pytest-asyncio
, pytestCheckHook
, pythonRelaxDepsHook
, uvicorn
, websockets
}:

buildPythonPackage rec {
  pname = "ypy-websocket";
  version = "0.12.2";
  format = "pyproject";

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "y-crdt";
    repo = "ypy-websocket";
    rev = "refs/tags/v${version}";
    hash = "sha256-3ANuIwRxUoFo5SSdTvBhTHExrYR7timu7XkE0t+UyWk=";
  };

  pythonRelaxDeps = [
    "aiofiles"
  ];

  nativeBuildInputs = [
    hatchling
    pythonRelaxDepsHook
  ];

  propagatedBuildInputs = [
    aiosqlite
    anyio
    y-py
  ];

  pythonImportsCheck = [
    "ypy_websocket"
  ];

  nativeCheckInputs = [
    pytest-asyncio
    pytestCheckHook
    uvicorn
    websockets
  ];

  disabledTestPaths = [
    # requires installing yjs Node.js module
    "tests/test_ypy_yjs.py"
  ];

  meta = {
    changelog = "https://github.com/y-crdt/ypy-websocket/blob/${src.rev}/CHANGELOG.md";
    description = "WebSocket Connector for Ypy";
    homepage = "https://github.com/y-crdt/ypy-websocket";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ dotlambda ];
  };
}
