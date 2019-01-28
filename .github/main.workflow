workflow "Build and Test" {
  on = "push"
  resolves = [
    "Master",
    "Lint",
  ]
}

action "Build" {
  uses = "jefftriplett/python-actions@master"
  args = "pip install -r requirements.txt"
}

action "Lint" {
  uses = "jefftriplett/python-actions@master"
  args = "black --check ."
  needs = ["Build"]
}

action "Test" {
  uses = "jefftriplett/python-actions@master"
  args = "pytest"
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
