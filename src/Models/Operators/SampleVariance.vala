/* SampleVariance.vala
 *
 * Copyright 2022 Diego Iván <diegoivan.mae@gmail.com>
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

using Math;
public class DescriptiveStatistics.SampleVariance : Operator {
    public override string name {
        get {
            return "Sample Variance";
        }
    }

    public SampleVariance (SharedData shared_data, Column column) {
        Object (
            shared_data: shared_data,
            column: column
        );
    }

    public override double calculate () {
        // Sum of Squares
        double ms = 0;
        foreach (double value in collect_values ()) {
            double dif = value - shared_data.mean;
            ms += (dif * dif);
        }

        shared_data.variance = ms / (shared_data.count - 1);
        return shared_data.variance;
    }
}
