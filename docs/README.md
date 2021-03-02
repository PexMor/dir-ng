# Dir for machines

Alternative for dir command for friends of structured data.

## Example output(s)

The output from simple `./dir.py docs` at the top of this repo.

### Hierarchical structure

__In a YAML__ form

```yaml
dirs: []
files:
- fname: docs/README.md
  hashes:
    md5: 7f70945f9cba0ad1b5962088d25e9f28
    sha1: b88d2f35a74147f83147c22f9648d5b44e54ad58
    sha256: 46cf3d782143961bb2195401b65986f5534a7cc19ffc80d560422b34dd2864f5
  mtime: 1614711833.7334096
  mtime_human: '2021-03-02 19:03:53.733410+00:00'
  name: README.md
  size: 71
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
```

__In a JSON__ form

```json
{
  "dirs": [],
  "files": [
    {
      "name": "README.md",
      "fname": "docs/README.md",
      "url": "https://www.example.com/docs/README.md",
      "size": 71,
      "mtime": 1614711833.7334096,
      "mtime_human": "2021-03-02 19:03:53.733410+00:00",
      "hashes": {
        "md5": "7f70945f9cba0ad1b5962088d25e9f28",
        "sha1": "b88d2f35a74147f83147c22f9648d5b44e54ad58",
        "sha256": "46cf3d782143961bb2195401b65986f5534a7cc19ffc80d560422b34dd2864f5"
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

### Flast structure

__In a YAML__ form

```yaml
docs:
- fname: docs/README.md
  hashes:
    md5: 7f70945f9cba0ad1b5962088d25e9f28
    sha1: b88d2f35a74147f83147c22f9648d5b44e54ad58
    sha256: 46cf3d782143961bb2195401b65986f5534a7cc19ffc80d560422b34dd2864f5
  mtime: 1614711833.7334096
  mtime_human: '2021-03-02 19:03:53.733410+00:00'
  name: README.md
  size: 71
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
```

__In a JSON__ form

```json
{
  "docs": [
    {
      "name": "README.md",
      "fname": "docs/README.md",
      "url": "https://www.example.com/docs/README.md",
      "size": 71,
      "mtime": 1614711833.7334096,
      "mtime_human": "2021-03-02 19:03:53.733410+00:00",
      "hashes": {
        "md5": "7f70945f9cba0ad1b5962088d25e9f28",
        "sha1": "b88d2f35a74147f83147c22f9648d5b44e54ad58",
        "sha256": "46cf3d782143961bb2195401b65986f5534a7cc19ffc80d560422b34dd2864f5"
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
