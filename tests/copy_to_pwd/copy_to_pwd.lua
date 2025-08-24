local copy_to_pwd = require("copy_to_pwd")

describe("copy_to_pwd setup", function()
  it("works with default configuration", function()
    copy_to_pwd.setup()
    assert(copy_to_pwd.config ~= nil, "config should be initialized")
    assert(copy_to_pwd.config.confirm_overwrite == true, "default confirm_overwrite should be true")
    assert(copy_to_pwd.config.notify_on_success == true, "default notify_on_success should be true")
    assert(copy_to_pwd.config.default_keymap == true, "default default_keymap should be true")
  end)

  it("works with custom configuration", function()
    copy_to_pwd.setup({
      confirm_overwrite = false,
      notify_on_success = false,
      default_keymap = false,
    })
    assert(copy_to_pwd.config.confirm_overwrite == false, "custom confirm_overwrite should be false")
    assert(copy_to_pwd.config.notify_on_success == false, "custom notify_on_success should be false")
    assert(copy_to_pwd.config.default_keymap == false, "custom default_keymap should be false")
  end)
end)

describe("copy_to_pwd functionality", function()
  before_each(function()
    copy_to_pwd.setup()
  end)

  it("can get current copy info", function()
    local info = copy_to_pwd.get_info()
    assert(type(info) == "table", "get_info should return a table")
    assert(type(info.current_file) == "string", "current_file should be a string")
    assert(type(info.pwd) == "string", "pwd should be a string")
    assert(type(info.target_path) == "string", "target_path should be a string")
  end)

  it("has proper API functions", function()
    assert(type(copy_to_pwd.copy_to_pwd) == "function", "copy_to_pwd should be a function")
    assert(type(copy_to_pwd.get_info) == "function", "get_info should be a function")
    assert(type(copy_to_pwd.setup) == "function", "setup should be a function")
  end)
end)
