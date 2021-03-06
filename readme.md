# neomura/setup-openscad-cli-action

GitHub Action to build and install the OpenSCAD CLI.

## License

While this repository is [MIT licensed](./license.md), it includes a Git submodule of the [OpenSCAD repository](https://github.com/openscad/openscad), which uses the GPL-2.0 license.

You should make your own checks to ensure that your usage of this GitHub action is valid within its license agreement.

## Supported virtual environments

Supported virtual environments are listed in the [test workflow](./.github/workflows/test.yaml).

## Usage

```yaml
on: [push]

jobs:
  example:
    runs-on: ubuntu-latest
    steps:

    # Load your repository.
    - uses: actions/checkout@v2

    # Install this github action.
    - uses: neomura/setup-openscad-cli-action@v1.0.1

    # OpenSCAD is now available on the path.
    - run: openscad --help
      shell: bash
```
