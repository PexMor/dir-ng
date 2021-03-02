# Dir for machines

Alternative for dir command for friends of structured data.

## Example output(s)

The output from simple `./dir.py docs` at the top of this repo.

The __hierarchical__ representation differs from __flat__ at the subfolder `images`.

### Hierarchical structure

__In a YAML__ form

```yaml
dirs:
- dirs: []
  files:
  - fname: docs/images/dummy.txt
    hashes:
      md5: eefa90588ca6d1b51819f6e661c0e2bd
      sha1: 06cfa7bd7a50ef6341d1e6069e9933b2f31a5a02
      sha256: 5e2d049814036605d06fbd394386cf9ec51c94380a1fb9497c243eba13fe7699
    mtime: 1614712469.746057
    mtime_human: '2021-03-02 19:14:29.746057+00:00'
    name: dummy.txt
    size: 29
    url: https://www.example.com/docs/images/dummy.txt
  self: docs/images
files:
- fname: docs/README.md
  hashes:
    md5: 55e457d659de121adc8438b8d0fb81b5
    sha1: 8d125c45161b1f0c94430cc079738dd1793be445
    sha256: f24405ae28577ae1b579827f14e899286ea1faff109c229eb07c5ca2ea2e3352
  mtime: 1614712532.4477177
  mtime_human: '2021-03-02 19:15:32.447718+00:00'
  name: README.md
  size: 5670
  url: https://www.example.com/docs/README.md
- fname: docs/.gitignore
  hashes:
    md5: 27f8fcb8c3704508d92f00b6d1dfeac4
    sha1: 1cb4d055d9745db39c840dd4aca1a6747a02f38e
    sha256: 97a0098274f0d27464eca02ba35e9dd03b8651bb6bda5203d1f5ba0fa717c81a
  mtime: 1610704894.0
  mtime_human: '2021-01-15 10:01:34+00:00'
  name: .gitignore
  size: 20
  url: https://www.example.com/docs/.gitignore
- fname: docs/_config.yml
  hashes:
    md5: 5c78ec68c28fbb6bed5854b673a4551e
    sha1: e8e93833fb3adc27d53935e878cc0a39d6d726e0
    sha256: 6a9d2ed4d1a52ef9e0d6ba075533b81c79cd41043cebb195014d4a07337be43c
  mtime: 1610709282.0
  mtime_human: '2021-01-15 11:14:42+00:00'
  name: _config.yml
  size: 136
  url: https://www.example.com/docs/_config.yml
self: docs
```

__In a JSON__ form

```json
{
  "self": "docs",
  "dirs": [
    {
      "self": "docs/images",
      "dirs": [],
      "files": [
        {
          "name": "dummy.txt",
          "fname": "docs/images/dummy.txt",
          "url": "https://www.example.com/docs/images/dummy.txt",
          "size": 29,
          "mtime": 1614712469.746057,
          "mtime_human": "2021-03-02 19:14:29.746057+00:00",
          "hashes": {
            "md5": "eefa90588ca6d1b51819f6e661c0e2bd",
            "sha1": "06cfa7bd7a50ef6341d1e6069e9933b2f31a5a02",
            "sha256": "5e2d049814036605d06fbd394386cf9ec51c94380a1fb9497c243eba13fe7699"
          }
        }
      ]
    }
  ],
  "files": [
    {
      "name": "README.md",
      "fname": "docs/README.md",
      "url": "https://www.example.com/docs/README.md",
      "size": 5670,
      "mtime": 1614712532.4477177,
      "mtime_human": "2021-03-02 19:15:32.447718+00:00",
      "hashes": {
        "md5": "55e457d659de121adc8438b8d0fb81b5",
        "sha1": "8d125c45161b1f0c94430cc079738dd1793be445",
        "sha256": "f24405ae28577ae1b579827f14e899286ea1faff109c229eb07c5ca2ea2e3352"
      }
    },
    {
      "name": ".gitignore",
      "fname": "docs/.gitignore",
      "url": "https://www.example.com/docs/.gitignore",
      "size": 20,
      "mtime": 1610704894.0,
      "mtime_human": "2021-01-15 10:01:34+00:00",
      "hashes": {
        "md5": "27f8fcb8c3704508d92f00b6d1dfeac4",
        "sha1": "1cb4d055d9745db39c840dd4aca1a6747a02f38e",
        "sha256": "97a0098274f0d27464eca02ba35e9dd03b8651bb6bda5203d1f5ba0fa717c81a"
      }
    },
    {
      "name": "_config.yml",
      "fname": "docs/_config.yml",
      "url": "https://www.example.com/docs/_config.yml",
      "size": 136,
      "mtime": 1610709282.0,
      "mtime_human": "2021-01-15 11:14:42+00:00",
      "hashes": {
        "md5": "5c78ec68c28fbb6bed5854b673a4551e",
        "sha1": "e8e93833fb3adc27d53935e878cc0a39d6d726e0",
        "sha256": "6a9d2ed4d1a52ef9e0d6ba075533b81c79cd41043cebb195014d4a07337be43c"
      }
    }
  ]
}
```

### Flat structure

__In a YAML__ form

```yaml
docs:
- fname: docs/README.md
  hashes:
    md5: 55e457d659de121adc8438b8d0fb81b5
    sha1: 8d125c45161b1f0c94430cc079738dd1793be445
    sha256: f24405ae28577ae1b579827f14e899286ea1faff109c229eb07c5ca2ea2e3352
  mtime: 1614712532.4477177
  mtime_human: '2021-03-02 19:15:32.447718+00:00'
  name: README.md
  size: 5670
  url: https://www.example.com/docs/README.md
- fname: docs/.gitignore
  hashes:
    md5: 27f8fcb8c3704508d92f00b6d1dfeac4
    sha1: 1cb4d055d9745db39c840dd4aca1a6747a02f38e
    sha256: 97a0098274f0d27464eca02ba35e9dd03b8651bb6bda5203d1f5ba0fa717c81a
  mtime: 1610704894.0
  mtime_human: '2021-01-15 10:01:34+00:00'
  name: .gitignore
  size: 20
  url: https://www.example.com/docs/.gitignore
- fname: docs/_config.yml
  hashes:
    md5: 5c78ec68c28fbb6bed5854b673a4551e
    sha1: e8e93833fb3adc27d53935e878cc0a39d6d726e0
    sha256: 6a9d2ed4d1a52ef9e0d6ba075533b81c79cd41043cebb195014d4a07337be43c
  mtime: 1610709282.0
  mtime_human: '2021-01-15 11:14:42+00:00'
  name: _config.yml
  size: 136
  url: https://www.example.com/docs/_config.yml
docs/images:
- fname: docs/images/dummy.txt
  hashes:
    md5: eefa90588ca6d1b51819f6e661c0e2bd
    sha1: 06cfa7bd7a50ef6341d1e6069e9933b2f31a5a02
    sha256: 5e2d049814036605d06fbd394386cf9ec51c94380a1fb9497c243eba13fe7699
  mtime: 1614712469.746057
  mtime_human: '2021-03-02 19:14:29.746057+00:00'
  name: dummy.txt
  size: 29
  url: https://www.example.com/docs/images/dummy.txt
```

__In a JSON__ form

```json
{
  "docs": [
    {
      "name": "README.md",
      "fname": "docs/README.md",
      "url": "https://www.example.com/docs/README.md",
      "size": 5670,
      "mtime": 1614712532.4477177,
      "mtime_human": "2021-03-02 19:15:32.447718+00:00",
      "hashes": {
        "md5": "55e457d659de121adc8438b8d0fb81b5",
        "sha1": "8d125c45161b1f0c94430cc079738dd1793be445",
        "sha256": "f24405ae28577ae1b579827f14e899286ea1faff109c229eb07c5ca2ea2e3352"
      }
    },
    {
      "name": ".gitignore",
      "fname": "docs/.gitignore",
      "url": "https://www.example.com/docs/.gitignore",
      "size": 20,
      "mtime": 1610704894.0,
      "mtime_human": "2021-01-15 10:01:34+00:00",
      "hashes": {
        "md5": "27f8fcb8c3704508d92f00b6d1dfeac4",
        "sha1": "1cb4d055d9745db39c840dd4aca1a6747a02f38e",
        "sha256": "97a0098274f0d27464eca02ba35e9dd03b8651bb6bda5203d1f5ba0fa717c81a"
      }
    },
    {
      "name": "_config.yml",
      "fname": "docs/_config.yml",
      "url": "https://www.example.com/docs/_config.yml",
      "size": 136,
      "mtime": 1610709282.0,
      "mtime_human": "2021-01-15 11:14:42+00:00",
      "hashes": {
        "md5": "5c78ec68c28fbb6bed5854b673a4551e",
        "sha1": "e8e93833fb3adc27d53935e878cc0a39d6d726e0",
        "sha256": "6a9d2ed4d1a52ef9e0d6ba075533b81c79cd41043cebb195014d4a07337be43c"
      }
    }
  ],
  "docs/images": [
    {
      "name": "dummy.txt",
      "fname": "docs/images/dummy.txt",
      "url": "https://www.example.com/docs/images/dummy.txt",
      "size": 29,
      "mtime": 1614712469.746057,
      "mtime_human": "2021-03-02 19:14:29.746057+00:00",
      "hashes": {
        "md5": "eefa90588ca6d1b51819f6e661c0e2bd",
        "sha1": "06cfa7bd7a50ef6341d1e6069e9933b2f31a5a02",
        "sha256": "5e2d049814036605d06fbd394386cf9ec51c94380a1fb9497c243eba13fe7699"
      }
    }
  ]
}
```
