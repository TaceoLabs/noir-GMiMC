# Noir GMiMC for BN254
 [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
 
This repository contains a Noir crate implementing the GMiMC block cipher for the native curve BN254.

GMiMC, or the Generalized MiMC family, is an extension of the Feistel-MiMC. Instead of using two branches, GMiMC generalizes the Feistel structures with $t (\geq 2)$ branches. GMiMC with $t=2$ is Feistel-MiMC.

GMiMC uses a Feistel round function where the mapping is $x \rightarrow x^d$. This construction leads to a cheap instantiation for SNARKs. Due to the characteristics of the underlying primefield, this particular implementation uses the round function $x \rightarrow x^5$.

For further information, you can read the [GMiMC Paper](https://eprint.iacr.org/2019/397.pdf).

## Installation

In your `Nargo.toml` file, add the following dependency:

```toml
[dependencies]
gmimc = { tag = "v0.1.0", git = "https://github.com/TaceoLabs/noir-GMiMC" }
```

## Examples

Our API uses an expanded form to call the GMiMC block cipher, similar to the Poseidon API from the Noir standard library to encrypt multiple `Field` elements at once. We use this approach so that we can use precomputed round constants (see Sage Section below) instead of computing them on the fly.
To encrypt two `Field` elements with a given key (which is also a `Field` element) write:

```Rust
    let plain = [3,4];
    let key = 0x2129347902376149;
    let cipher = gmimc::bn254::enc::x5_2(plain, key);
    let is_plain = gmimc::bn254::dec::x5_2(cipher, key);
    assert(is_plain == plain);
```
**Note:** The GMiMC block cipher has a configurable branch width, the example above uses a 2-branch Feistel network (Feistel-MiMC). If encrypting a large number of blocks, using an instance with a larger branch number is more efficient.

For further examples on how to use the GMiMC crate, have a look in the `lib.nr` file in the `src/` directory. You can find the tests for all expanded forms of the GMiMC block cipher there.

## Sage Script

You can find a Sage implementation of GMiMC under `tools/`. We used this script to generate the round constants defined in `src/bn254/consts.nr`. The script was written with all current attacks and analysis in mind.

## Disclaimer

This is **experimental software** and is provided on an "as is" and "as available" basis. We do **not give any warranties** and will **not be liable for any losses** incurred through any use of this code base.
