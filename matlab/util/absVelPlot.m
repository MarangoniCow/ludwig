absVel1 = colloid1_velocity(1, :).^2 + colloid1_velocity(2, :).^2 + colloid1_velocity(3, :).^2;
absVel1 = sqrt(absVel1);

absVel2 = colloid2_velocity(1, :).^2 + colloid2_velocity(2, :).^2 + colloid2_velocity(3, :).^2;
absVel2 = sqrt(absVel2);

absVel3 = colloid3_velocity(1, :).^2 + colloid3_velocity(2, :).^2 + colloid3_velocity(3, :).^2;
absVel3 = sqrt(absVel3);

absVel4 = colloid4_velocity(1, :).^2 + colloid4_velocity(2, :).^2 + colloid4_velocity(3, :).^2;
absVel4 = sqrt(absVel4);

absVel5 = colloid5_velocity(1, :).^2 + colloid5_velocity(2, :).^2 + colloid5_velocity(3, :).^2;
absVel5 = sqrt(absVel5);




figure
plot(absVel1)
hold on
plot(absVel2)
plot(absVel3)
plot(absVel4)
plot(absVel5)
hold off
legend({'$a0/h = 0.23$', '$a0/h = 0.18$', '$a0/h = 0.15$', '$a0/h = 0.13$', '$a0/h = 0.11$'})
legend('interpreter', 'latex', 'FontSize', 12);