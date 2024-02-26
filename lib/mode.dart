enum Mode {
  create('New university', 'Next'),
  edit('Edit university', 'Done'),
  idle('', '');

  final String title;
  final String buttonTitle;

  const Mode(this.title, this.buttonTitle);
}
