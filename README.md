# `ezpypir`

`ezpypir` is an easy PyPI releaser tool.

## Usage

Switch to the project directory.

```shell
ezpypir [release_type]
```

It will bump the version, commit the changes, push the changes, push the tags, build the package, and then post the resulting builds to PyPI.

## Notes

- Yes, this relies on your `bumpversion` config file already being set
