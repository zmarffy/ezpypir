# `ezpypir`

`ezpypir` is an easy PyPI releaser tool, best used in conjunction with `bumpversion`.

## Usage

Switch to the project directory.

If you have `bumpversion` installed, `ezpypr` is used like this.

```shell
ezpypir [release_type]
```

It will bump the version, build the package, and then post the resulting builds to PyPI.

If you don't have `bumpversion`, it is used like this.

```shell
ezpypir [version]
```

It will build the package and then post the resulting builds to PyPI. Make sure the version is correct, as that is what it uses to find the built files.

## Notes

- Yes, this relies on your `bumpversion` config file already being set. No, there is no way to **not** use `bumpversion` if it is installed. I do not have plans to make it **not** like that any time soon. I may change my mind though
