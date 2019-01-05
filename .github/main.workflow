workflow "Build and Test" {
  on = "push"
  resolves = [
    "Test",
    "Master",
  ]
}

action "Build" {
  uses = "jefftriplett/python-actions/action-pip@master"
  args = "install -r requirements.txt"
}

action "Test" {
  uses = "jefftriplett/python-actions/action-black@master"
  args = "."
  needs = ["Build"]
}

action "jefftriplett/python-actions/action-pytest@master" {
  uses = "jefftriplett/python-actions/action-pytest@master"
  args = "."
  needs = ["Build"]
}

action "Master" {
  uses = "actions/bin/filter@master"
  needs = ["jefftriplett/python-actions/action-pytest@master", "Test"]
  args = "branch master"
}
