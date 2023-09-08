mod bn254; // Instantiations of GMiMC for prime field of the same order as BN254

use crate::field::modulus_num_bits;

struct GmimcConfig<R> {
    alpha: Field, // S-box power; depends on the underlying field
    arc: [Field; R], // round constants
}

fn config<R> (alpha: Field, arc: [Field; R]) -> GmimcConfig<R> {
    GmimcConfig {
        alpha: alpha,
        arc: arc,
    }
}


fn round<T>(mut state: [Field; T], key: Field, alpha: Field, arc: Field) -> [Field; T] {
    let sum = state[0] + key + arc;
    let power = sum.pow_32(alpha);
    for i in 1..T {
        state[i] += power;
    }
    state
}

fn dec_round<T>(mut state: [Field; T], key: Field, alpha: Field, arc: Field) -> [Field; T] {
    let sum = state[0] + key + arc;
    let power = sum.pow_32(alpha);
    for i in 1..T {
        state[i] -= power;
    }
    state
}

fn feistel_shift<T>(mut state: [Field; T]) -> [Field; T]  {
    let tmp = state[T - 1];
    for i in 1..T {
        state[T - i] = state[T - i - 1];
    }
    state[0] = tmp;
    state
}

fn inv_feistel_shift<T>(mut state: [Field; T]) -> [Field; T]  {
    let tmp = state[0];
    for i in 0..T - 1 {
        state[i] = state[i + 1];
    }
    state[T - 1] = tmp;
    state
}


// General GMiMC block cipher
fn encrypt<T, R>(gmimc_conf: GmimcConfig<R>, mut x: [Field; T], k: Field) -> [Field; T] {
    assert(modulus_num_bits() as u16 >= 128); // otherwise key is too small

    let GmimcConfig {alpha, arc} = gmimc_conf;

    for r in 0..R - 1 {
        x = round(x, k, alpha, arc[r]);
        x = feistel_shift(x);
    }
    x = round(x, k, alpha, arc[R - 1]);
    x
}

fn decrypt<T, R>(gmimc_conf: GmimcConfig<R>, mut x: [Field; T], k: Field) -> [Field; T] {
    assert(modulus_num_bits() as u16 >= 128); // otherwise key is too small

    let GmimcConfig {alpha, arc} = gmimc_conf;

    for r in 1..R {
        x = dec_round(x, k, alpha, arc[R - r]);
        x = inv_feistel_shift(x);
    }
    x = dec_round(x, k, alpha, arc[0]);
    x
}
