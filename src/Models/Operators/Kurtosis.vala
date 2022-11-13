/* Kurtosis.vala
 *
 * Copyright 2022 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

using Math;
public class DescriptiveStatistics.Kurtosis : Operator {
    public override string name {
        get {
            return "Kurtosis";
        }
    }

    public Kurtosis (SharedData shared_data, Column column) {
        Object (
            shared_data: shared_data,
            column: column
        );
    }

    public override double calculate () {
        return (Formulas.centered_moment (collect_values (), shared_data.mean, 4) / pow (shared_data.std_dev, 4)) - 3;
    }
}

namespace DescriptiveStatistics.Formulas {
    public double centered_moment (double[] values, double mean, int n_moment) {
        double sum = 0;
        foreach (double val in values) {
            sum += pow (val - mean, n_moment);
        }

        return sum / values.length;
    }
}
