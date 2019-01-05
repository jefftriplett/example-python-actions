workflow "Build and Test" {
  on = "push"
  resolves = [
    "Master",
    "Lint",
  ]
}

action "Build" {
  uses = "jefftriplett/python-actions/action-pip@master"
  args = "install -r requirements.txt"
}

action "Lint" {
  uses = "jefftriplett/python-actions/action-black@master"
  args = "."
  needs = ["Build"]
}

action "Test" {
  uses = "jefftriplett/python-actions/action-pytest@master"
  args = "."
  needs = ["Build"]
}

action "Master" {
  uses = "actions/bin/filter@master"
  needs = [
    "Lint",
    "Test",
  ]
  args = "branch master"
}
