resource "opentelekomcloud_fgs_function_v2" "myfunction" {

  name = "myfunction"
  app  = "default"

  handler = "index.handler"

  runtime = "Python3.10"

  initializer_handler = "index.init"
  initializer_timeout = 3

  #initializer_handler = null
  #initializer_timeout = null

  code_type     = "inline"
  func_code     = filebase64(format("${path.module}/code.py"))
  code_filename = "index.py"

  description      = "Test function"
  memory_size      = 128
  timeout          = 3
  max_instance_num = 11


}